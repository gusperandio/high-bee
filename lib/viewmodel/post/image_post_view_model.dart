import 'dart:io';

import 'package:flutter/widgets.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePostViewModel extends ChangeNotifier {
  File? selectedImage;

  Future<void> pickImage() async {
    try {
      final status = await Permission.storage.request();
      final returnedImage = await ImagePicker().pickImage(
        source: ImageSource.gallery,
      );

      if (returnedImage == null) return;

      selectedImage = File(returnedImage.path);

      // if (status.isGranted) {
      //   final ImagePicker picker = ImagePicker();
      //   final XFile? image = await picker.pickImage(
      //     source: ImageSource.gallery,
      //   );

      //   if (image != null) {
      //     selectedImage = image;
      //   }
      // } else if (status.isPermanentlyDenied) {
      //   openAppSettings();
      // }
    } finally {
      notifyListeners();
    }
  }
}
