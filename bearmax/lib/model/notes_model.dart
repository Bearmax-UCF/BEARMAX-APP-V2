class NotesResponse {
  final List<Note> allNotes;

  NotesResponse({required this.allNotes});

  factory NotesResponse.fromJson(Map<String, dynamic> json) {
    List<dynamic> notesJson = json["allNotes"];
    List<Note> allNotes = notesJson.map((noteJson) => Note.fromJson(noteJson)).toList();
    return NotesResponse(
      allNotes: allNotes
    );
  }
}

class Note{
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

  factory Note.fromJson(Map<String, dynamic> json){
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