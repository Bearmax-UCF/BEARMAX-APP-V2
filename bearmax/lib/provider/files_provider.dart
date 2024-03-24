import 'package:bearmax/model/user_files_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:bearmax/api/api_service.dart';

class FileProvider extends ChangeNotifier {
  final ApiService _apiService = ApiService();
  List<FileBlob> _files = [];
  bool _isLoading = false;
  String _error = '';

  List<FileBlob> get files => _files;
  bool get isLoading => _isLoading;
  String get error => _error;

  Future<void> fetchAllFiles(BuildContext context) async {
    try {
      if (kDebugMode) {
        print("PROVIDER");
      }
      _isLoading = true;
      notifyListeners();
      _files = await _apiService.allFiles(context);
      if (kDebugMode) {
        print("HEREEEEEEE");
        print(_files);
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
