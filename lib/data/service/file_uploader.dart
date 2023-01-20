import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FileUploader {
  static Future<String> imageUploader(XFile xFile) async {
    String downloadUrl = "";
    final storageRef = FirebaseStorage.instance.ref();
    var imageRef = storageRef.child("images/UserImages/${xFile.name}");
    await imageRef.putFile(File(xFile.path));
    downloadUrl = await imageRef.getDownloadURL();
    return downloadUrl;
  }

  static Future<String> fileUploader(File file,String fileName) async {
    String downloadUrl = "";
    final storageRef = FirebaseStorage.instance.ref();
    var imageRef = storageRef.child("files/pdf/$fileName");
    await imageRef.putFile(File(file.path));
    downloadUrl = await imageRef.getDownloadURL();
    print("FILE DOWNLOAD URL:$downloadUrl");
    return downloadUrl;
  }
}
