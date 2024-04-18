class NewNoteResponse {
  final String title;
  final String date;
  final String note;
  final String userID;
  final String noteID;
  final String message;

  NewNoteResponse(
      {required this.title,
      required this.date,
      required this.note,
      required this.userID,
      required this.noteID,
      required this.message});

  factory NewNoteResponse.fromJson(Map<String, dynamic> json) {
    final newNote = json["newNote"];
    return NewNoteResponse(
        title: newNote["title"] ?? "",
        date: newNote["date"] ?? "",
        note: newNote["note"] ?? "",
        userID: newNote["userID"] ?? "",
        noteID: newNote["_id"] ?? "",
        message: json["message"] ?? "");
  }
}

class NewNoteRequest {
  String title;
  DateTime date;
  String note;

  NewNoteRequest({required this.title, required this.date, required this.note});

  Map<String, dynamic> toJson() {
    Map<String, dynamic> map = {
      'title': title.trim(),
      'date': date.toIso8601String(),
      'note': note,
    };

    return map;
  }
}
