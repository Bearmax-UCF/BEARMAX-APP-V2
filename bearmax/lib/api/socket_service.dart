import 'package:bearmax/util/api_endpoints.dart';
import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

class SocketService {
  late io.Socket socket;
  final String authToken;
  final String userID;

  SocketService(this.authToken, this.userID) {
    const fullURL = ApiEndPoints.socketUrl;
    final Map<String, String> query = {'userID': userID};
    socket = io.io(
        fullURL,
        io.OptionBuilder()
            .setTransports(['websocket'])
            .disableAutoConnect()
            .setAuth({'Authorization': 'Bearer $authToken'})
            .setQuery(query)
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

// Match the pose - happy, sad, angry, confused, shocked, worried, scared, annoyed
  void emotion(String myEmotion) {
    socket.emit('emotionGame', myEmotion);
  }

// Play sensory overload
  void sensoryOverload(String name, bool video, bool audio) {
    String map =
        '{"mediaName": "$name","videoBool": $video,"audioBool": $audio}';

    socket.emit('playMedia', map);

    if (kDebugMode) {
      print("Playing: $name");
    }
  }

  // Disconnect
  void disconnect() {
    socket.disconnect();
  }
}
