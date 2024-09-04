import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart' as p;


class StorageService { 
  final FirebaseStorage _firebaseStorage = FirebaseStorage.instance;
  
  StorageService();

  Future<String> uploadUserPic({required File file, required String uid}) async {
    // Create a reference to the file location in Firebase Storage
    Reference fileRef = _firebaseStorage
        .ref('users/pfps')
        .child('$uid${p.extension(file.path)}');

    // Start the file upload
    UploadTask task = fileRef.putFile(file);

    // Handle the upload result
    return task.then((p) async {
      if (p.state == TaskState.success) {
        // If upload is successful, return the download URL
        return await fileRef.getDownloadURL();
      } else {
        // Handle the error if upload failed
        throw Exception("Upload failed");
      }
    });
  }

  Future<String?> uploadingImagesToChat({required File file, required String chatId}) async{
    Reference fileRef = _firebaseStorage
      .ref('chats/$chatId')
      .child('${DateTime.now().toIso8601String()}${p.extension(file.path)}'
    ); 
    UploadTask task = fileRef.putFile(file); 
    return task.then((p) async {
      if (p.state == TaskState.success) {
        // If upload is successful, return the download URL
        return await fileRef.getDownloadURL();
      } else {
        // Handle the error if upload failed
        throw Exception("Upload failed");
      }
    });
  } 
} 