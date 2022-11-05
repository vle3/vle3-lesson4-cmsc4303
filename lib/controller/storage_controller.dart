import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:lesson4/model/constants.dart';
import 'package:uuid/uuid.dart';

class StorageController {
  static const photoFolder = 'photo_files';

  static Future<Map<ArgKey, String>> uploadPhotoFile({
    required File photo,
    String? filename,
    required String uid,
    required Function listener,
  }) async {
    filename ??= '$photoFolder/$uid/${const Uuid().v1()}';
    UploadTask task = FirebaseStorage.instance.ref(filename).putFile(photo);
    task.snapshotEvents.listen((TaskSnapshot event) {
      int progress = (event.bytesTransferred / event.totalBytes * 100).toInt();
      listener(progress);
    });
    TaskSnapshot snapshot = await task;
    String downloadURL = await snapshot.ref.getDownloadURL();
    return {
      ArgKey.filename: filename,
      ArgKey.downloadURL: downloadURL,
    };
  }
}
