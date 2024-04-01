import 'dart:convert';
import 'dart:io';

import 'package:bearmax/util/api_endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  late io.Socket socket;
  final String authToken;
  final String userID;

  Map<String, dynamic> emotionGameData = {
    "Correct": [1, 1, 1, 1],
    "Wrong": [0, 0, 0, 0],
    "GameFin": "2024-03-16T22:38:24.000Z",
    "UserID": "65c109110cbf9a30562f70fc",
    "NumPlays": 2
  };

  SocketService(this.authToken, this.userID) {
    final fullURL = "${ApiEndPoints.socketUrl}?userID=$userID";
    socket = io.io(
        fullURL,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setAuth({'Authorization': 'Bearer $authToken'})
            .build());

    if (kDebugMode) {
      print('HTTP_PROXY: ${Platform.environment['HTTP_PROXY']}');
  print('NO_PROXY: ${Platform.environment['NO_PROXY']}');
  print('');
      print('Connecting to URL: ${socket.io.uri}');
    }

    // Connect and check connection
    socket.connect();
    socket.onConnect((_) {
      if (kDebugMode) {
        print('Connected');
      }
    });

    socket.onConnectError((error) {
      if (kDebugMode) {
        print('Connection error: $error');
      }
    });

    socket.onDisconnect((_) {
      if (kDebugMode) {
        print('Disconnected');
      }
    });
  }

  //Start game
  void startEmotionGame() {
    socket.emit('emotionGame', 'start');
  }

  // Stop Game
  void stopEmotionGame() {
    socket.emit('emotionGame', 'stop');
    saveGameData(emotionGameData);
  }

  // Save data
  void saveGameData(Map<String, dynamic> data) {
    socket.emit('emotionGameStats', json.encode(data));
  }

  // Play sensory overload
  void sensoryOverload(String url) {
    Map<String, dynamic> sensoryOverloadData = {
      "mediaURL": url,
    };

    socket.emit('playMedia', json.encode(sensoryOverloadData));

    if (kDebugMode) {
      print("Playing: $url");
    }
  }

  // Disconnect
  void disconnect() {
    socket.disconnect();
  }
}
