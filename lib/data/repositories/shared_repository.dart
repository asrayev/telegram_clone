//
//
// class StorageRepository {
//   // Saving data
//   static Future<bool> saveUserId(String userId) async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.setString("userId", userId);
//   }
//
// // Retrieving data
//   static Future<String> getUserId() async {
//     final prefs = await SharedPreferences.getInstance();
//     return prefs.getString("userId") ?? "";
//   }
// }
