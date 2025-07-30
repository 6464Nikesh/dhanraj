import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

import '../utils/preference_key.dart';

enum SubscriptionType {
  watchlist,
  openTrades,
  // Add more if needed
}

class WebSocketService with ChangeNotifier {
  WebSocketChannel? _channel;
  bool _isConnected = false;
  bool _isMarketClosed = false;

  // Store latest data per subscription type
  Map<SubscriptionType, Map<int, dynamic>> latestData = {
    SubscriptionType.watchlist: {},
    SubscriptionType.openTrades: {},
  };


  Future<void> connect() async {
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
        _reconnect();
      },
      onError: (error) {
        debugPrint("⚠️ WebSocket error: $error");
        _reconnect();
      },
    );
  }

  void _handleMessage(dynamic data) {
    debugPrint("📥 Received: $data");
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
      latestData[SubscriptionType.watchlist]![token] = payload;
      notifyListeners();


      notifyListeners();
    } else if (decoded['type'] == 'open_trades' && decoded['payload'] != null) {
      latestData[SubscriptionType.openTrades] = decoded['payload'];
      notifyListeners();
    } else {
      debugPrint("ℹ️ Unknown message type: ${decoded['type']}");
    }
  }

  void subscribeToWatchlist(int watchlistId) {
    if (!_isConnected) return;

    final message = {
      "action": "subscribe",
      "watchlistId": watchlistId,
    };
    _channel?.sink.add(jsonEncode(message));
    debugPrint("📡 Subscribed to watchlist $watchlistId");
  }

  void subscribeToOpenTrades() {
    if (!_isConnected) return;

    final message = {
      "action": "subscribe_open_trades",
    };
    _channel?.sink.add(jsonEncode(message));
    debugPrint("📡 Subscribed to open trades");
  }

  void unsubscribeFromWatchlist(int watchlistId) {
    final message = {
      "action": "unsubscribe",
      "watchlistId": watchlistId,
    };
    _channel?.sink.add(jsonEncode(message));
    debugPrint("❌ Unsubscribed from watchlist $watchlistId");
  }

  void unsubscribeFromOpenTrades() {
    final message = {
      "action": "unsubscribe_open_trades",
    };
    _channel?.sink.add(jsonEncode(message));
    debugPrint("❌ Unsubscribed from open trades");
  }

  void _reconnect() {
    Future.delayed(const Duration(seconds: 3), () {
      debugPrint("🔁 Reconnecting...");
      _isConnected = false;
      connect();
    });
  }

  void disconnect() {
    _isConnected = false;
    _channel?.sink.close();
    _channel = null;
  }
}
