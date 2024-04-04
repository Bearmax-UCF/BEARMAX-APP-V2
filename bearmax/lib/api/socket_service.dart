import 'dart:convert';

import 'package:bearmax/util/api_endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  late io.Socket socket;
  final String authToken;
  final String userID;

  SocketService(this.authToken, this.userID) {
    final fullURL = "${ApiEndPoints.socketUrl}?userID=$userID";
    socket = io.io(
        fullURL,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setAuth({'Authorization': 'Bearer $authToken'})
            .build());

    // Connect and check connection
    socket.connect();
    socket.onConnect((_) {
      if (kDebugMode) {
        print('Connected Successfully');
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
