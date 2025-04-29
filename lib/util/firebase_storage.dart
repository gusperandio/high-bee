import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

class FirebaseStorageService {
  final firebase_storage.FirebaseStorage _storage =
      firebase_storage.FirebaseStorage.instance;

  Future<List<String>> uploadImages({
    required List<File> images,
    required String folderName,
  }) async {
    List<String> downloadUrls = [];

    for (File image in images) {
      final String timestamp = DateTime.now().millisecondsSinceEpoch.toString();
      final String filePath = '$folderName/$timestamp.jpg';

      final ref = _storage.ref().child(filePath);
      final uploadTask = ref.putFile(image);

      final snapshot = await uploadTask.whenComplete(() {});
      final downloadUrl = await snapshot.ref.getDownloadURL();
      downloadUrls.add(downloadUrl);
    }

    return downloadUrls;  
  }
}
