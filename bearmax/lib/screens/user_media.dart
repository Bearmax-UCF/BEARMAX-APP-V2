import 'dart:convert';

import 'package:bearmax/api/api_service.dart';
import 'package:bearmax/model/user_files_model.dart';
import 'package:bearmax/provider/files_provider.dart';
import 'package:bearmax/provider/media_provider.dart';
import 'package:bearmax/util/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mime/mime.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserMediaScreen extends StatefulWidget {
  const UserMediaScreen({super.key});

  @override
  State<UserMediaScreen> createState() => _UserMediaScreenState();
}

class _UserMediaScreenState extends State<UserMediaScreen> {
  bool isFavorited = false;
  String? favoritedAudioFile;
  String? favoritedVideoFile;

  @override
  void initState() {
    super.initState();
    _loadFavoritedFiles();
  }

  void _loadFavoritedFiles() async {
    final prefs = await SharedPreferences.getInstance();
    setState(() {
      favoritedAudioFile = prefs.getString('favoritedAudioFile');
      favoritedVideoFile = prefs.getString('favoritedVideoFile');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('My Media'),
      ),
      body: Stack(children: [
        RefreshIndicator(
          onRefresh: () async {
            await Provider.of<FileProvider>(context, listen: false)
                .fetchAllFiles(context);
          },
          child: Consumer<FileProvider>(
            builder: (context, fileProvider, child) {
              if (fileProvider.isLoading) {
                return const Center(
                  child: CircularProgressIndicator(),
                );
              } else if (fileProvider.error.isNotEmpty) {
                return Center(
                  child: Text(fileProvider.error),
                );
              } else {
                return ListView.builder(
                  itemCount: fileProvider.files.length,
                  itemBuilder: (context, index) {
                    FileBlob file = fileProvider.files[index];
                    return singleFile(file);
                  },
                );
              }
            },
          ),
        ),
        Positioned(
          bottom: 30,
          right: 20,
          child: addMedia(context),
        ),
      ]),
    );
  }

  // Single File
  Widget singleFile(FileBlob file) {
    return Padding(
        padding: const EdgeInsets.only(left: 25, right: 25.0),
        child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 5),
              Container(
                height: 97,
                decoration: const BoxDecoration(
                  color: Palette.backgroundColor,
                  border: Border(
                      left: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      right: BorderSide(
                        color: Colors.grey,
                        width: 0.5,
                      ),
                      bottom: BorderSide(
                        color: Colors.grey,
                        width: 1,
                      )),
                  borderRadius: BorderRadius.all(Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                        color: Palette.shadow,
                        spreadRadius: 1,
                        blurRadius: 2,
                        offset: Offset(0, 3)),
                  ],
                ),
                child: ListTile(
                  contentPadding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  leading: IconButton(
                      highlightColor: Colors.transparent,
                      splashColor: Colors.transparent,
                      hoverColor: Colors.transparent,
                      icon: favoritedAudioFile == file.blobName ||
                              favoritedVideoFile == file.blobName
                          ? const Icon(Icons.favorite,
                              color: Palette.stopEmotionGameColor)
                          : const Icon(Icons.favorite_border_outlined),
                      onPressed: () {
                        // Audio
                        if (file.blobName.contains('.mp3')) {
                          if (favoritedAudioFile == file.blobName) {
                            // If it's already favorited, un-favorite it
                            setState(() {
                              favoritedAudioFile = null;
                            });
                          } else {
                            // If it's not favorited, set it as the new favorite and update the state
                            setState(() {
                              favoritedAudioFile = file.blobName;
                              Provider.of<MediaProvider>(context, listen: false)
                                  .setAudioURL(file.blobName);
                            });
                          }
                        }

                        // Video
                        if (file.blobName.contains('.mp4')) {
                          if (favoritedVideoFile == file.blobName) {
                            // If it's already favorited, un-favorite it
                            setState(() {
                              favoritedVideoFile = null;
                            });
                          } else {
                            // If it's not favorited, set it as the new favorite and update the state
                            setState(() {
                              favoritedVideoFile = file.blobName;
                              Provider.of<MediaProvider>(context, listen: false)
                                  .setVideoURL(file.blobName);
                            });
                          }
                        }
                      }),
                  title: Text(file.blobName,
                      textAlign: TextAlign.left,
                      style: const TextStyle(
                          color: Palette.black, fontWeight: FontWeight.bold)),
                  onTap: () {
                    // Open file
                  },
                ),
              ),
              const SizedBox(height: 5)
            ]));
  }

  Widget addMedia(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        // add media popup
        pickFile(context);
      },
      style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
          padding: const EdgeInsets.all(10),
          backgroundColor: Palette.accentColor,
          foregroundColor: Palette.accentColorTwo,
          shadowColor: Palette.darkShadow,
          elevation: 6),
      child: const Icon(Icons.add, size: 35.0, color: Colors.white),
    );
  }

  void pickFile(BuildContext context) async {
    // Choose audio or video file
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'mp4'],
    );

    if (result == null || result.files.isEmpty) {
      throw Exception('No files picked or file picker was canceled');
    }

    // Post to API
    ApiService apiService = ApiService();
    // ignore: use_build_context_synchronously
    await apiService.addFile(context, result).then((value) async {
      String val = await value.stream.bytesToString();
      Map<String, dynamic> responseBody = json.decode(val);
      if (value.statusCode == 200) {
        const snackBar = SnackBar(content: Text('File uploaded successfully'));
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      } 

      else {
        var snackBar = SnackBar(content: Text(responseBody['message']));
        // ignore: use_build_context_synchronously
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
      }
    });
  }
}
