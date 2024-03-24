class GetAllUserFilesResponse {
  final String message;
  final List<FileBlob> allFiles;

  GetAllUserFilesResponse({
    required this.message,
    required this.allFiles
  });

  factory GetAllUserFilesResponse.fromJson(Map<String, dynamic> json) {
       List<dynamic> filesJson = json["blobsList"];
    List<FileBlob> allFiles =
        filesJson.map((fileJson) => FileBlob.fromJson(fileJson)).toList();
    return GetAllUserFilesResponse(
      message: json["message"],
      allFiles: allFiles);
  }
}

class GetUserFileResponse {
    final String blobName;
    final String message;

  GetUserFileResponse({
    required this.blobName,
    required this.message,
  });

  factory GetUserFileResponse.fromJson(Map<String, dynamic> json) {
    return GetUserFileResponse(
      blobName: json["blobName"], 
      message: json["message"], 
    );
  }
}

class FileBlob {
  String blobName;
  String blobUrl;

  FileBlob({
    required this.blobName,
    required this.blobUrl
  });

  factory FileBlob.fromJson(Map<String, dynamic> json) {
    return FileBlob(
      blobName: json["blobName"], 
      blobUrl: json["blobUrl"]
      );
  }
}