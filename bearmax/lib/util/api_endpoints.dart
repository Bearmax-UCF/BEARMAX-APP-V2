class ApiEndPoints {
  static const String liveBaseUrl = 'https://bearmaxcare.com/';
  static const String localBaseUrl = 'http://10.0.2.2:8080/';
  static const String localHost = 'ws://10.0.2.2:8080';

  // Verification
  static const String register = '${liveBaseUrl}api/auth/register';
  static const String login = '${liveBaseUrl}api/auth/login';
  static const String forgotPassword = '${localBaseUrl}api/auth/forgotPasswordRequest'; //
  static const String emailVerification = '${localBaseUrl}api/auth/verify?token=&id='; // 

  // User Information
  static const String userInfo = '${liveBaseUrl}api/users/me'; //
  static const String editUser = '${liveBaseUrl}api/users/'; //

  // Notes
  static const String note = '${liveBaseUrl}api/note';
  static const String updateNote = '${liveBaseUrl}api/note/:id';

  // Media
  static const String uploadAudio = '${localBaseUrl}api/uploadFiles/uploadAudio/';
  static const String uploadVideo = '${localBaseUrl}api/uploadFiles/uploadVideo/';
  static const String getAllFiles =  '${localBaseUrl}api/azureBlob/listBlobs/';
  
  //static const String azureBlob = '${localBaseUrl}api/azureBlob/getBlob/:id';
  //static const String azureContainer = '${localBaseUrl}api/azureContainer/:id';
  //static const String delEmotionRecognition = '${localBaseUrl}api/emotionRecognition/:id';
}