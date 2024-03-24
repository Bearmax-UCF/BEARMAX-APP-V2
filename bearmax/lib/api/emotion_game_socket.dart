import 'dart:convert';

import 'package:bearmax/util/api_endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class EmotionGameSocketService {
  late io.Socket socket;
  final String authToken;
  final String userID;
  Map<String, dynamic> data = {
    "Correct": [1, 1, 1, 1],
    "Wrong": [0, 0, 0, 0],
    "GameFin": "2024-03-16T22:38:24.000Z",
    "UserID": "65c109110cbf9a30562f70fc",
    "NumPlays": 2
  };

  EmotionGameSocketService(this.authToken, this.userID) {
    final fullURL = "${ApiEndPoints.localHost}?userID=$userID";
    socket = io.io(
        fullURL,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setAuth({'Authorization': 'Bearer $authToken'})
            .build());

    if (kDebugMode) {
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
    saveGameData(data);
  }

  // Save data
  void saveGameData(Map<String, dynamic> data) {
    socket.emit('emotionGameStats', json.encode(data));
  }

  // Disconnect
  void disconnect() {
    socket.disconnect();
  }
}
