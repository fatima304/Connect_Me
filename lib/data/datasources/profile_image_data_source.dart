import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';

class ProfileImageDataSource {
  final ImagePicker _imagePicker = ImagePicker();

  Future<String?> pickAndSaveImage(String uid) async {
    final XFile? pickedImage = await _imagePicker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 85,
    );

    if (pickedImage == null) return null;

    final directory = await getApplicationDocumentsDirectory();

    final extension = pickedImage.name.contains('.')
        ? pickedImage.name.split('.').last
        : 'jpg';

    final imagePath = '${directory.path}/${uid}_profile.$extension';

    final savedImage = await File(pickedImage.path).copy(imagePath);

    return savedImage.path;
  }

  Future<String?> getSavedImagePath(String uid) async {
    final directory = await getApplicationDocumentsDirectory();

    final files = directory.listSync();

    for (final file in files) {
      if (file is File &&
          file.path.split('/').last.startsWith('${uid}_profile.')) {
        return file.path;
      }
    }

    return null;
  }
}