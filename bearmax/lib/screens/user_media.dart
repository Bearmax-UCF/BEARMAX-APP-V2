import 'dart:convert';

import 'package:bearmax/api/api_service.dart';
import 'package:bearmax/model/user_files_model.dart';
import 'package:bearmax/provider/files_provider.dart';
import 'package:bearmax/util/colors.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:mime/mime.dart';

class UserMediaScreen extends StatefulWidget {
  const UserMediaScreen({super.key});

  @override
  State<UserMediaScreen> createState() => _UserMediaScreenState();
}

class _UserMediaScreenState extends State<UserMediaScreen> {
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
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 5),
              Container(
                height: 97,
                decoration: const BoxDecoration(
                  color: Palette.backgroundColor,
                  border: Border(
                      left: BorderSide(
                        color: Colors.grey, // specify your color here
                        width: 0.5, // specify your width here
                      ),
                      right: BorderSide(
                        color: Colors.grey, // specify your color here
                        width: 0.5, // specify your width here
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
                  title: Text(file.blobName,
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

    final result = await FilePicker.platform.pickFiles(
     
    );

    if (result == null || result.files.isEmpty) {
      throw Exception('No files picked or file picker was canceled');
    }


    /*
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      //type: FileType.custom,
      //allowedExtensions: ['mp3', 'mp4'],
    );

    

    if (result != null && result.files.single.path != null) {
      //final mimeType = lookupMimeType(result.files.single.path);
      /*
      final filepath = result.files.single.path;
      if(filepath != null) {
        final mimeType = lookupMimeType(filepath);
        if (mimeType != null) {
          if (kDebugMode) {
            print('MIME type: $mimeType');
          }
        }
      }

*/ added
      
final filePath = result.files.single.path;
  if (filePath != null) {
    final mimeType = lookupMimeType(filePath);
    if (mimeType != null) {
      // Use the MIME type
      print('MIME type: $mimeType');
    } 
      */
      /// Load result and file details
      //PlatformFile file = result.files.first;

      // Call api
      ApiService apiService = ApiService();
      //apiService.addFile(context, result);
     
      //apiService.addFile(context,result);

      /*
      // ignore: use_build_context_synchronously
      apiService.addFile(context, result).then((value) {
        Map<String, dynamic> responseBody = json.decode(value.body);

        if(kDebugMode) {
          print(value.statusCode);
        }

        if (value.statusCode == 200) {
          var snackBar = SnackBar(content: Text(responseBody["blobName"]));
        ScaffoldMessenger.of(context).showSnackBar(snackBar);
        } else {
          var snackBar = SnackBar(content: Text(responseBody['message']));
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
        }
      }
      );*/

      
    } 
  }
