import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';

class ImagePickerService {
   ImagePickerService();
  // Image picker function
  Future<XFile?> pickImage(ImageSource source) async {
    try {
      final ImagePicker picker = ImagePicker();
      final XFile? image = await picker.pickImage(source: source);
      return image; // Returns XFile? (nullable)
    } catch (e) {
      debugPrint("Error picking image: $e");
      return null; // Handle errors gracefully
    }
  }

  Future<XFile> fixFrontCameraMirrorXFile(XFile xfile) async {
    // Read bytes from XFile
    final Uint8List bytes = await xfile.readAsBytes();

    // Decode image
    final img.Image? original = img.decodeImage(bytes);
    if (original == null) return xfile;

    // Flip horizontally
    final img.Image fixed = img.flipHorizontal(original);

    // Encode back to JPG
    final List<int> fixedBytes = img.encodeJpg(
      fixed,
      quality: 95,
    );

    // Write back to same path
    final File file = File(xfile.path);
    await file.writeAsBytes(fixedBytes, flush: true);

    // Return new XFile
    return XFile(file.path);
  }


  Future<XFile?> networkImageToXFile(String url) async {
    try {
      // Download the image from the network
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        // Get the temporary directory
        Directory tempDir = await getTemporaryDirectory();
        String tempPath = '${tempDir.path}/temp_image${DateTime.timestamp()}.jpg';

        // Delete old file if it exists
        File file = File(tempPath);
        await file.writeAsBytes(response.bodyBytes);

        // Convert to XFile
        return XFile(file.path);
      }
    } catch (e) {
      debugPrint("Error downloading image: $e");
    }
    return null;
  }


  Future<void> clearCache() async {
    try {
      Directory tempDir = await getTemporaryDirectory();

      if (tempDir.existsSync()) {
        tempDir.deleteSync(recursive: true); // Deletes all cached files
        debugPrint("✅ Cache cleared: ${tempDir.path}");
      }
    } catch (e) {
      debugPrint("⚠️ Error clearing cache: $e");
    }
  }

  void clearAppCache() async {
    await clearCache(); // Delete all cache files
    imageCache.clear(); // Clear Flutter's image cache
    imageCache.clearLiveImages();
  }

}