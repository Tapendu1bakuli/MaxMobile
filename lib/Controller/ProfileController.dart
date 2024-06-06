import 'dart:io';

import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ProfileController extends GetxController {
  File? profilePicture;

  Future<void> selectProfilePicture() async {
    final pickedImage = await ImagePicker().getImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      profilePicture = File(pickedImage.path);
      update(); // Notify GetX that the state has changed
    }
  }
}