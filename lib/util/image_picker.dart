import 'package:image_picker/image_picker.dart';
import 'dart:io';

class CustomImagePicker {
  Future<File> uploadImage(String inputSource) async {
    final picker = ImagePicker();
    final XFile? pickedImage = await picker.pickImage(
      source:
          inputSource == 'cammera' ? ImageSource.camera : ImageSource.gallery,
    );

    if (pickedImage != null) {
      return File(pickedImage.path);
    } else {
      throw Exception('No image selected');
    }
  }
}
