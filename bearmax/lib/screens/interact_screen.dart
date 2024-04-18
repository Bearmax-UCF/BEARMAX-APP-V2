import 'package:bearmax/api/socket_service.dart';
import 'package:bearmax/provider/auth_provider.dart';
import 'package:bearmax/provider/media_provider.dart';
import 'package:bearmax/provider/user_provider.dart';
import 'package:bearmax/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class InteractScreen extends StatefulWidget {
  const InteractScreen({super.key});

  @override
  State<InteractScreen> createState() => _InteractScreenState();
}

class _InteractScreenState extends State<InteractScreen> {
  bool emotionGameisPlaying = false;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    final authToken =
        Provider.of<AuthProvider>(context, listen: true).authToken;
    final userID = Provider.of<AuthProvider>(context, listen: true).authID;

    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Palette.primaryColor,
        child: Stack(
          children: <Widget>[
            Positioned.fill(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const SizedBox(height: 80),
                  Padding(
                    padding: EdgeInsets.only(
                      top: MediaQuery.of(context).size.height * 0.05,
                      bottom: MediaQuery.of(context).size.height * 0.05,
                      left: MediaQuery.of(context).size.width * 0.1,
                      right: MediaQuery.of(context).size.width * 0.1,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        displayWelcome(context),
                        const SizedBox(height: 10),
                        displayTime(),
                        const SizedBox(height: 20),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Positioned.fill(
              top: MediaQuery.of(context).size.height * 0.33,
              child: displayMain(height, width, authToken, userID),
            ),
          ],
        ),
      ),
    );
  }

  // Popup menu for stress detection
  Widget bottomMenu(SocketService socket) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        ListTile(
          leading: const Icon(Icons.videocam),
          title: const Text('Play Video'),
          onTap: () {
            // Handle option 1
            Navigator.pop(context);

            // Call socket with video
            if (Provider.of<MediaProvider>(context, listen: false).videoURL ==
                '') {
              const snackBar = SnackBar(
                  content: Text('Please select valid .mp4 file in My Media'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              socket.sensoryOverload(
                  Provider.of<MediaProvider>(context, listen: false).videoURL,
                  true,
                  false);
            }
          },
        ),
        ListTile(
          leading: const Icon(Icons.audiotrack),
          title: const Text('Play Audio'),
          onTap: () {
            // Handle option 2
            Navigator.pop(context);

            // Call socket with audio
            if (Provider.of<MediaProvider>(context, listen: false).audioURL ==
                '') {
              const snackBar = SnackBar(
                  content: Text('Please select valid .mp3 file in My Media'));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            } else {
              socket.sensoryOverload(
                  Provider.of<MediaProvider>(context, listen: false).audioURL,
                  false,
                  true);
            }
          },
        ),
      ],
    );
  }

  // Display stress detection button
  Widget stressDetectionButton(height, width, SocketService socket) {
    final buttonWidth = width * 0.65;
    final buttonHeight = height * 0.13;
    return ElevatedButton(
        onPressed: () {
          // Choose from video or image
          showModalBottomSheet(
            context: context,
            builder: (BuildContext context) {
              return bottomMenu(socket);
            },
          );
        },
        style: ButtonStyle(
          backgroundColor:
              MaterialStateProperty.all<Color>(Palette.interactColor),
          shape:
              MaterialStateProperty.all<OutlinedBorder>(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20.0),
          )),
          fixedSize:
              MaterialStateProperty.all<Size>(Size(buttonWidth, buttonHeight)),
        ),
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.favorite, color: Palette.backgroundColor),
              SizedBox(height: 5),
              Text(
                  textAlign: TextAlign.center,
                  'Stress Relief',
                  style: TextStyle(
                    color: Palette.backgroundColor,
                    fontSize: 18,
                  ))
            ]));
  }

  Widget emotionTile(String emotion, IconData icon, VoidCallback onPressed) {
    return ListTile(
      leading: Icon(icon),
      title: Text(emotion),
      onTap: onPressed,
    );
  }

  // happy, sad, angry, confused, shocked, worried, scared, annoyed
  Widget emotionGameMenu(SocketService socket) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        emotionTile('Happy', Icons.sentiment_satisfied_alt, () {
          Navigator.pop(context);
          socket.emotion('happy');
        }),
        emotionTile('Sad', Icons.sentiment_dissatisfied_rounded, () {
          Navigator.pop(context);
          socket.emotion('sad');
        }),
        emotionTile('Angry', Icons.sentiment_very_dissatisfied_sharp, () {
          Navigator.pop(context);
          socket.emotion('angry');
        }),
        emotionTile('Confused', Icons.question_mark, () {
          Navigator.pop(context);
          socket.emotion('confused');
        }),
        emotionTile('Shocked', Icons.error_outline, () {
          Navigator.pop(context);
          socket.emotion('shocked');
        }),
        emotionTile('Worried', Icons.sentiment_dissatisfied, () {
          Navigator.pop(context);
          socket.emotion('worried');
        }),
        emotionTile('Scared', Icons.warning, () {
          Navigator.pop(context);
          socket.emotion('scared');
        }),
        emotionTile('Annoyed', Icons.sentiment_neutral_outlined, () {
          Navigator.pop(context);
          socket.emotion('annoyed');
        })
      ],
    );
  }

  //  Display emotion game button
  Widget emotionGameButton(height, width, authToken, socket) {
    final buttonWidth = width * 0.65;
    final buttonHeight = height * 0.13;

    return ElevatedButton(
        onPressed: () {
          // Bring up poses tab
          showModalBottomSheet(
            isDismissible: true,
            isScrollControlled: true,
            context: context,
            builder: (BuildContext c) {
              return Padding(
                  padding:
                      EdgeInsets.only(top: MediaQuery.of(context).padding.top),
                  child: emotionGameMenu(socket));
            },
          );
        },
        style: ButtonStyle(
          backgroundColor: emotionGameisPlaying
              ? MaterialStateProperty.all<Color>(Palette.stopEmotionGameColor)
              : MaterialStateProperty.all<Color>(Palette.interactColor),
          shape: MaterialStateProperty.all<OutlinedBorder>(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20.0),
            ),
          ),
          fixedSize:
              MaterialStateProperty.all<Size>(Size(buttonWidth, buttonHeight)),
        ),
        child: const Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.accessibility_new, color: Palette.backgroundColor),
              SizedBox(height: 5),
              Text(
                  textAlign: TextAlign.center,
                  "Match the Pose",
                  style: TextStyle(
                    color: Palette.backgroundColor,
                    fontSize: 18,
                  ))
            ]));
  }

  // Display bear picture
  Widget displayPicture() {
    return Container(
        color: Colors.transparent,
        height: 180,
        width: 200,
        child: Image.asset(
          'assets/images/bearmax-panda-face-no-title.png',
          fit: BoxFit.cover,
        ));
  }

  // Display main area
  Widget displayMain(height, width, authToken, userID) {
    SocketService socket = SocketService(authToken, userID);

    return SizedBox(
        height: 400,
        width: MediaQuery.of(context).size.width,
        child: Container(
            decoration: const BoxDecoration(
                color: Palette.backgroundColor,
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60))),
            child: Padding(
                padding: EdgeInsets.only(
                  top: MediaQuery.of(context).size.height * 0.01,
                  bottom: MediaQuery.of(context).size.height * 0.035,
                  left: MediaQuery.of(context).size.width * 0.1,
                  right: MediaQuery.of(context).size.width * 0.1,
                ),
                child: Column(children: <Widget>[
                  displayPicture(),
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        emotionGameButton(height, width, authToken, socket),
                        const SizedBox(height: 20),
                        stressDetectionButton(height, width, socket),
                      ])
                ]))));
  }

  // Display formatted time
  Widget displayTime() {
    return Text(DateFormat.yMMMEd().format(DateTime.now()),
        style: const TextStyle(
            fontFamily: 'Roboto', fontSize: 18, color: Palette.secondaryColor));
  }

  // Display and update welcome message
  Widget displayWelcome(BuildContext context) {
    return Consumer<UserProvider>(
      builder: (context, userProvider, _) {
        final firstName = userProvider.firstName;

        return Column(
          children: <Widget>[
            Text(
              "Hello, $firstName",
              style: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 40,
                color: Palette.secondaryColor,
              ),
            )
          ],
        );
      },
    );
  }
}
