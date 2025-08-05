import 'dart:convert';
import 'package:dhanraj/provider/position_provider.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../utils/preference_key.dart';

class WebSocketService with ChangeNotifier {
  WebSocketChannel? _channel;
  bool _isConnected = false;
  bool _isMarketClosed = false;
  num? _pendingWatchlistId;
  bool? _isSubscribedToOpenTrades = false;

  BuildContext? _positionProviderContext;

  void registerContext(BuildContext context) {
    _positionProviderContext = context;
  }

  String removeTrailingZeros(String value) {
    double val = double.tryParse(value) ?? 0.0;

    if (val == 0) return '';
    if (value.contains('.')) {
      // Remove trailing zeros and dot if nothing remains after dot
      value = " ${value.replaceFirst(RegExp(r'\.0+$'), '')}"; // e.g., 12.0000 -> 12
    }
    return value;
  }

  // Store latest data per subscription type
  Map<int, dynamic> latestData = {};

  Future<void> connect({required BuildContext context}) async {
    if (_isConnected) return;

    SharedPreferences sp = await SharedPreferences.getInstance();
    final token = sp.getString(PreferenceKey.token) ?? "";

    if (token.isEmpty) {
      debugPrint("❌ No token found.");
      return;
    }

    final url = 'wss://dhanrajtrading.in/api/v1/market-data/live-stream?token=$token';
    debugPrint("🌐 Connecting to: $url");

    _channel = WebSocketChannel.connect(Uri.parse(url));
    _isConnected = true;

    _channel!.stream.listen(
      _handleMessage,
      onDone: () {
        _isConnected = false;
        debugPrint("🛑 WebSocket closed");
        _reconnect(context);
      },
      onError: (error) {
        _isConnected = false;
        debugPrint("⚠️ WebSocket error: $error");
        _reconnect(context);
      },
    );
  }

  void _handleMessage(dynamic data) {
    final decoded = jsonDecode(data);

    if (decoded['type'] == 'info' && decoded['message'] == 'Market is closed') {
      _isMarketClosed = true;
      debugPrint("🚫 Market closed");
      _channel?.sink.close();
      return;
    }

    // Handle different types
    if (decoded['type'] == 'tick' && decoded['payload'] != null) {
      final payload = decoded['payload'];
      final int token = payload['instrument_token'];

      // Store tick data by token
      latestData[token] = payload;
      notifyListeners();
    } else if (decoded['type'] == 'trade_tp_hit' || decoded['type'] == 'trade_sl_hit') {
      if (_positionProviderContext != null) {
        Provider.of<PositionProvider>(_positionProviderContext!, listen: false).getPositionList(context: _positionProviderContext!);
      }
    }
  }

  void subscribeToWatchlist(num watchlistId) {
    if (_channel == null) {
      debugPrint("⚠️ Not connected. Will subscribe on reconnect to watchlist $watchlistId");
      return;
    }

    try {
      final message = {
        "action": "subscribe",
        "watchlistId": watchlistId,
      };
      _channel?.sink.add(jsonEncode(message));
      debugPrint("📡 Subscribed to watchlist $watchlistId");
      _pendingWatchlistId = null; // Clear after success
    } catch (e) {
      debugPrint("🚨 Failed to unsubscribe: $e");
      _isConnected = false;
      _channel = null; // Reset so next call triggers reconnect
      _pendingWatchlistId = watchlistId;
    }
    notifyListeners();
  }

  void subscribeToOpenTrades() {
    if (_channel == null) {
      debugPrint("⚠️ Not connected. Will subscribe to open trades on reconnect.");
      return;
    }

    try {
      final message = {
        "action": "subscribe_open_trades",
      };
      _channel?.sink.add(jsonEncode(message));
      _isSubscribedToOpenTrades = true; // ✅ Update state
      debugPrint("📡 Subscribed to open trades");
    } catch (e) {
      debugPrint("🚨 Failed to unsubscribe: $e");
      _isConnected = false;
      _channel = null; // Reset so next call triggers reconnect
      _isSubscribedToOpenTrades = false; // optional fallback
    }
    notifyListeners();
  }

  void unsubscribeFromWatchlist(int watchlistId) {
    if (_channel == null) {
      debugPrint("⚠️ Cannot unsubscribe – socket not connected.");
      return;
    }

    try {
      final message = {
        "action": "unsubscribe",
        "watchlistId": watchlistId,
      };
      _channel!.sink.add(jsonEncode(message));
      debugPrint("❌ Unsubscribed from watchlist $watchlistId");
    } catch (e) {
      debugPrint("🚨 Failed to unsubscribe: $e");
      _isConnected = false;
      _channel = null; // Reset so next call triggers reconnect
    }
    notifyListeners();
  }

  void unsubscribeFromOpenTrades() {
    if (_channel == null) {
      debugPrint("⚠️ Cannot unsubscribe – socket not connected.");
      return;
    }

    try {
      final message = {
        "action": "unsubscribe_open_trades",
      };
      _channel?.sink.add(jsonEncode(message));
      debugPrint("❌ Unsubscribed from open trades");
      _isSubscribedToOpenTrades = false; // ✅ Update state
    } catch (e) {
      debugPrint("🚨 Failed to unsubscribe: $e");
      _isConnected = false;
      _channel = null; // Reset so next call triggers reconnect
      _isSubscribedToOpenTrades = false; // fallback
    }
    notifyListeners();
  }

  Future<void> _reconnect(BuildContext context) async {
    Future.delayed(const Duration(seconds: 3), () {
      debugPrint("🔁 Reconnecting...");
      _isConnected = false;
      connect(context: context);
    });

    await Future.delayed(const Duration(seconds: 1));

    if (_pendingWatchlistId != null) {
      subscribeToWatchlist(_pendingWatchlistId!);
    }

    if (_isSubscribedToOpenTrades ?? false) {
      subscribeToOpenTrades();
    }
  }

  void disconnect() {
    _isConnected = false;
    _channel?.sink.close();
    _channel = null;
  }
}
