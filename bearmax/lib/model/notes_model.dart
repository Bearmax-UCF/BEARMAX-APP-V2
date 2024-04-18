class GetDeleteNoteResponse {
  final String id;
  final String title;
  final String date;
  final String note;
  final String userID;
  final int version;

  GetDeleteNoteResponse(
      {required this.id,
      required this.title,
      required this.date,
      required this.note,
      required this.userID,
      required this.version});

  factory GetDeleteNoteResponse.fromJson(Map<String, dynamic> json) {
    return GetDeleteNoteResponse(
        id: json["_id"],
        title: json["title"],
        date: json["date"],
        note: json["note"],
        userID: json["userID"],
        version: json["__v"]);
  }
}

class NotesResponse {
  final List<Note> allNotes;

  NotesResponse({required this.allNotes});

  factory NotesResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> notesJson = json["allNotes"];
    List<Note> allNotes =
        notesJson.map((noteJson) => Note.fromJson(noteJson)).toList();
    return NotesResponse(allNotes: allNotes);
  }
}

class EditNoteRequest {
  String? title;
  String? note;

  EditNoteRequest({this.title, this.note});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {'title': title?.trim(), 'note': note?.trim()};

    return map;
  }
}

class Note {
  String id;
  String title;
  String date;
  String note;
  String userID;
  int version;

  Note({
    required this.id,
    required this.title,
    required this.date,
    required this.note,
    required this.userID,
    required this.version,
  });

  factory Note.fromJson(Map<String, dynamic> json) {
    return Note(
      id: json["_id"] ?? "",
      title: json["title"] ?? "",
      date: json["date"] ?? "",
      note: json["note"] ?? "",
      userID: json["userID"] ?? "",
      version: json["__v"] ?? 0,
    );
  }
}
