import 'package:bearmax/model/notes_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bearmax/api/api_service.dart';

class NoteProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<Note> _notes = [];
  bool _isLoading = false;
  String _error = '';

  List<Note> get notes => _notes;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchAllNotes(BuildContext context) async {
  try {
    if(kDebugMode) {
      print("PROVIDER");
    }
    _isLoading = true;
    notifyListeners();
    _notes = await _apiService.allNotes(context);
    if(kDebugMode){
      print("HEREEEEEEE");
      print(_notes);
    }
    notifyListeners();
    _error = '';
  } catch (e) {
    _error = e.toString();
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}
}
