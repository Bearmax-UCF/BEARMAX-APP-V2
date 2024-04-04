class ApiEndPoints {
  static const String liveBaseUrl = 'https://bearmaxcare.com/';
  static const String socketUrl = 'wss://bearmaxcare.com';

  // Verification
  static const String register = '${liveBaseUrl}api/auth/register';
  static const String login = '${liveBaseUrl}api/auth/login';
  static const String forgotPassword = '${liveBaseUrl}api/auth/forgotPasswordRequest';

  // User Information
  static const String userInfo = '${liveBaseUrl}api/users/me'; 
  static const String editUser = '${liveBaseUrl}api/users/'; 

  // Notes
  static const String note = '${liveBaseUrl}api/note';
  static const String updateNote = '${liveBaseUrl}api/note/:id';

  // Media
  static const String uploadAudio = '${liveBaseUrl}api/uploadFiles/uploadAudio/';
  static const String uploadVideo = '${liveBaseUrl}api/uploadFiles/uploadVideo/';
  static const String getAllFiles =  '${liveBaseUrl}api/azureBlob/listBlobs/';
}