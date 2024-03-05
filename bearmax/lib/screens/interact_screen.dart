import 'dart:convert';

import 'package:bearmax/util/colors.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:bearmax/api/api_service.dart';

class InteractScreen extends StatelessWidget {
  const InteractScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        color: Palette.primaryColor,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const SizedBox(
              height: 80,
            ),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  FutureBuilder(
                    future: ApiService.getUser(context),
                    builder: (context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.waiting) {
                        return const Center(child: CircularProgressIndicator());
                      } else if (snapshot.hasError) {
                        return Center(child: Text('Error: ${snapshot.error}'));
                      } else if (!snapshot.hasData) {
                        return const Center(child: Text('No data available'));
                      } else {
                        final userData = json.decode(snapshot.data.body);
                        final firstName = userData['me']['firstName'];
                        return Column(
                          children: <Widget>[
                            Text(
                              "Hello, $firstName",
                              style: const TextStyle(
                                  fontFamily: 'Roboto',
                                  fontSize: 40,
                                  color: Palette.secondaryColor),
                            ),
                          ],
                        );
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    DateFormat.yMMMEd().format(DateTime.now()),
                    style: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 18,
                        color: Palette.secondaryColor),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Flexible(
              child: Container(
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(60),
                        topRight: Radius.circular(60))),
                child: Padding(
                  padding: const EdgeInsets.all(30),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        color: Colors.transparent,
                        height: 80,
                        width: 80,
                        child: Image.asset(
                          'assets/images/face.png',
                          fit: BoxFit.cover,
                        ),
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Palette.accentColorTwo),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Adjust the value to change the roundness
                                  ),
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    const Size(120, 120)),
                              ),
                              child: const Column(children: [
                                SizedBox(height: 20),
                                Icon(Icons.emoji_emotions_outlined,
                                    color: Palette.backgroundColor),
                                SizedBox(height: 5),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Emotion Game',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ])),
                          ElevatedButton(
                              onPressed: () {
                                // Button 2 action
                              },
                              style: ButtonStyle(
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Palette.accentColorTwo),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Adjust the value to change the roundness
                                  ),
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    Size(120, 120)),
                              ),
                              child: const Column(children: [
                                SizedBox(height: 20),
                                Icon(Icons.favorite,
                                    color: Palette.backgroundColor),
                                SizedBox(height: 5),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Stress Relief',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontSize: 18,
                                  ),
                                ),
                              ])),
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
                                backgroundColor:
                                    MaterialStateProperty.all<Color>(
                                        Palette.accentColor),
                                shape:
                                    MaterialStateProperty.all<OutlinedBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        20.0), // Adjust the value to change the roundness
                                  ),
                                ),
                                fixedSize: MaterialStateProperty.all<Size>(
                                    Size(270, 120)),
                              ),
                              child: const Column(children: [
                                SizedBox(height: 30),
                                Icon(Icons.pause,
                                    color: Palette.backgroundColor, size: 24),
                                SizedBox(height: 5),
                                Text(
                                  textAlign: TextAlign.center,
                                  'Stop',
                                  style: TextStyle(
                                    color: Palette.backgroundColor,
                                    fontSize: 25,
                                  ),
                                ),
                              ])),
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
