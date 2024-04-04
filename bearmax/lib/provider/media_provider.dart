import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MediaProvider extends ChangeNotifier {
  String _audioURL = '';
  String get audioURL => _audioURL;

  String _videoURL = '';
  String get videoURL => _videoURL;

  Future<void> setAudioURL(String audioURL) async {
    _audioURL = audioURL;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('audioURL', audioURL);
  }

  Future<void> loadAudioURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _audioURL = prefs.getString('audioURL') ?? '';
    notifyListeners();
  }

  Future<void> setVideoURL(String videoURL) async {
    _videoURL = videoURL;
    notifyListeners();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('videoURL', videoURL);
  }

  Future<void> loadVideoURL() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _videoURL = prefs.getString('videoURL') ?? '';
    notifyListeners();
  }
}
