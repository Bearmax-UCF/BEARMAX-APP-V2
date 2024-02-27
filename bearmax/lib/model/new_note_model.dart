class NewNoteResponse {
  final String title;
  final String date;
  final String note;
  final String userID;
  final String noteID;

  NewNoteResponse({
    required this.title,
    required this.date,
    required this.note,
    required this.userID,
    required this.noteID
  });

  factory NewNoteResponse.fromJson(Map<String, dynamic> json) {
    return NewNoteResponse(
      title: json["title"] ?? "",
      date: json["date"] ?? "",
      note: json["note"] ?? "",
      userID: json["userID"] ?? "",
      noteID: json["_id"] ?? "",
    );
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