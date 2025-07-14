import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:web_socket_channel/web_socket_channel.dart';

class WebSocketService with ChangeNotifier {
  WebSocketChannel? _channel;
  int _currentWatchlistId = 0;
  bool _marketClosed = false;

  final Map<int, Map<String, dynamic>> _instrumentData = {};

  Map<int, Map<String, dynamic>> get instrumentData => _instrumentData;

  void connect(String token) {
    final url = 'wss://dhanrajtrading.in/api/v1/market-data/live-stream?token=$token';
    _channel = WebSocketChannel.connect(Uri.parse(url));
    _channel!.stream.listen(
      _handleMessage,
      onError: (err) {
        print(err);
        _reconnect(token);
      },
      onDone: () {
        _reconnect(token);
      },
    );
  }

  void _handleMessage(dynamic data) {

    final m = jsonDecode(data);

    // Check for market closed info
    if (m['type'] == 'info' && m['message'] == 'Market is closed') {
      _marketClosed = true;
      notifyListeners(); // So UI or provider can react
      debugPrint("Market is closed. Stopping socket actions.");
      _channel?.sink.close(); // Optional: close connection early
      return;
    }

    if (_marketClosed) return; // Don't process any further messages

    final jsonData = jsonDecode(data);
    if (jsonData['type'] == 'tick' && jsonData['payload'] != null) {
      final payload = jsonData['payload'];
      final int token = payload['instrument_token'];
      _instrumentData[token] = payload;
      notifyListeners();
    }
  }

  void subscribe(int watchListId) {
    if (_marketClosed) {
      debugPrint("Market is closed. Skipping subscription.");
      return;
    }


    if (_currentWatchlistId == watchListId) return;

    // Unsubscribe previous
    unsubscribe(_currentWatchlistId);

    // Subscribe new
    final message = {
      "action": "subscribe",
      "watchlistId": watchListId,
    };
    _channel?.sink.add(jsonEncode(message));

    _currentWatchlistId = watchListId;

    debugPrint("Subscribed to watchlist: $watchListId");
  }

  void unsubscribe(int watchListId) {
    final message = {
      "action": "unsubscribe",
      "watchlistId": watchListId,
    };
    _channel?.sink.add(jsonEncode(message));
    _instrumentData.remove(watchListId);
    if (_currentWatchlistId == watchListId) {
      _currentWatchlistId = 0;
    }

    debugPrint("Unsubscribed from watchlist: $watchListId");
    notifyListeners();
  }

  void _reconnect(String tokan) {
    if (_marketClosed) {
      debugPrint("Market is closed. Not reconnecting.");
      return;
    }
    _channel = null;
    Future.delayed(const Duration(seconds: 3), () {
      connect(tokan);
      if (_currentWatchlistId != 0) {
        subscribe(_currentWatchlistId);
      }
    });
  }

  void disposeSocket(int watchListId) {
    if (_currentWatchlistId != 0) {
      unsubscribe(_currentWatchlistId);
    }
    _channel?.sink.close();
    _channel = null;
    debugPrint("WebSocket closed.");
  }
}
