
import 'package:bearmax/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class InteractScreen extends StatelessWidget {
  const InteractScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Pallete.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 80,),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  const Text(
                    "Hello, Savannah", // USER
                    style: TextStyle(fontFamily: 'Roboto', fontSize: 40, color: Pallete.secondaryColor),
                  ),
                  const SizedBox(height: 10,),
                  Text(
                    DateFormat.yMMMEd().format(DateTime.now()),
                    style: const TextStyle(fontFamily: 'Roboto', fontSize: 18, color: Pallete.secondaryColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                ),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 15,),
                      Container(
                        color: Colors.transparent,
                        height: 80,
                        width: 80,
                        child: Image.asset('assets/images/face.png', fit: BoxFit.cover,),
                      ),
                      const SizedBox(height: 45),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Button 1 action
                            },
                             style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Pallete.accentColorTwo),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0), // Adjust the value to change the roundness
                                ),
                              ),
                              fixedSize: MaterialStateProperty.all<Size>(const Size(120, 120)),
                            ),
                           
                            child: const Column(
                              children: [
                                SizedBox(height: 20),
                                Icon(Icons.emoji_emotions_outlined, color: Pallete.backgroundColor),
                                SizedBox(height: 5),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Emotion Game', 
                                  style: TextStyle(
                                  color: Pallete.backgroundColor,
                                  fontSize: 18,
                                  ),
                                ),
                              ]
                            )
                          ),
                          ElevatedButton(
                            onPressed: () {
                              // Button 2 action
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Pallete.accentColorTwo),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0), // Adjust the value to change the roundness
                                ),
                              ),
                              fixedSize: MaterialStateProperty.all<Size>(Size(120, 120)),
                            ),
                            child: const Column(
                              children: [
                                SizedBox(height: 20),
                                Icon(Icons.favorite, color: Pallete.backgroundColor),
                                SizedBox(height: 5),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Stress Relief', 
                                  style: TextStyle(
                                  color: Pallete.backgroundColor,
                                  fontSize: 18,
                                  ),
                                ),
                              ]
                            )
                          ),
                        ],
                      ),
                      const SizedBox(height: 20),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          ElevatedButton(
                            onPressed: () {
                              // Button 4 action
                            },
                            style: ButtonStyle(
                              backgroundColor: MaterialStateProperty.all<Color>(Pallete.accentColor),
                              shape: MaterialStateProperty.all<OutlinedBorder>(
                                RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(20.0), // Adjust the value to change the roundness
                                ),
                              ),
                              fixedSize: MaterialStateProperty.all<Size>(Size(270, 120)),
                            ),
                            child: const Column(
                              children: [
                                SizedBox(height: 30),
                                Icon(Icons.pause, color: Pallete.backgroundColor, size: 24),
                                SizedBox(height: 5),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Stop', 
                                  style: TextStyle(
                                  color: Pallete.backgroundColor,
                                  fontSize: 25,
                                  ),
                                ),
                              ]
                            )
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
