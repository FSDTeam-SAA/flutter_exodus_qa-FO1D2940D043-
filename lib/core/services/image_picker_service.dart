
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerService {
  final ImagePicker _picker = ImagePicker();

  /// Pick a single image from gallery or camera
  Future<XFile?> pickImage({bool fromCamera = false}) async {
    try {
      return await _picker.pickImage(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
        maxWidth: 1800,
        maxHeight: 1800,
      );
    } catch (e) {
      debugPrint('Error picking image: $e');
      return null;
    }
  }

  /// Pick multiple images (not supported on all platforms)
  Future<List<XFile>?> pickMultipleImages() async {
    try {
      return await _picker.pickMultiImage();
    } catch (e) {
      debugPrint('Error picking multiple images: $e');
      return null;
    }
  }

  /// Pick a video from gallery or camera
  Future<XFile?> pickVideo({bool fromCamera = false}) async {
    try {
      return await _picker.pickVideo(
        source: fromCamera ? ImageSource.camera : ImageSource.gallery,
      );
    } catch (e) {
      debugPrint('Error picking video: $e');
      return null;
    }
  }

  /// Checks if the given file has an image extension.
  bool isImage(XFile file) {
    final imageExtensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp', '.heic'];
    final path = file.path.toLowerCase();
    return imageExtensions.any((ext) => path.endsWith(ext));
  }

  /// Checks if the given file has a video extension.
  bool isVideo(XFile file) {
    final videoExtensions = ['.mp4', '.mov', '.avi', '.wmv', '.flv', '.mkv', '.webm'];
    final path = file.path.toLowerCase();
    return videoExtensions.any((ext) => path.endsWith(ext));
  }
}
