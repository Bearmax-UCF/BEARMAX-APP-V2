class ApiEndPoints {
  static const String liveBaseUrl = 'http://bearmaxcare.com/'; // https?
  static const String localBaseUrl = 'http://10.0.2.2:8080/';
  //static const String localHost = 'localhost:8080';
  static const String localHost = 'ws://10.0.2.2:8080';
  
  static const String azureBlob = '${localBaseUrl}api/azureBlob/getBlob/:id';
  static const String azureContainer = '${localBaseUrl}api/azureContainer/:id';
  //static const String delEmotionRecognition = '${localBaseUrl}api/emotionRecognition/:id';
  static const String register = '${localBaseUrl}api/auth/register';
  static const String login = '${localBaseUrl}api/auth/login';
  static const String emailVerification = '${localBaseUrl}api/auth/verify?token=&id=';
  static const String note = '${localBaseUrl}api/note';
  static const String updateNote = '${localBaseUrl}api/note/:id';
  //static const String uploadAudio = '${localBaseUrl}api/uploadFiles/uploadAudio/:id';
  //static const String uploadVideo = '${localBaseUrl}api/uploadFiles/uploadVideo/:id';
  //static const String userFiles = '${localBaseUrl}api/userFiles/:id';
  //static const String delUserFiles = '${localBaseUrl}api/userFiles/deleteUserFile/:id';
  //static const String delUserMedia = '${localBaseUrl}api/userFiles/deleteFileEntry/:id';
  //static const String userPreferences = '${localBaseUrl}api/userPreferences/:id';
  static const String userInfo = '${localBaseUrl}api/users/me';
  static const String editUser = '${localBaseUrl}api/users/';

  static const String uploadAudio = '${localBaseUrl}api/uploadFiles/uploadAudio/';
  static const String uploadVideo = '${localBaseUrl}api/uploadFiles/uploadVideo/';
  static const String getAllFiles =  '${localBaseUrl}api/azureBlob/listBlobs/';
}