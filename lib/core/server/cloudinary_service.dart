import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';

class CloudinaryService {
  CloudinaryService({
    this.cloudName = 'dghtbue90',
    this.uploadPreset = 'sacny_preset',
  });

  final String cloudName;
  final String uploadPreset;

  Future<List<String>> uploadImages(List<XFile> images) async {
    final imageUrls = <String>[];

    try {
      for (final image in images) {
        final imageBytes = await image.readAsBytes();
        final request = http.MultipartRequest(
          'POST',
          Uri.parse(
            'https://api.cloudinary.com/v1_1/$cloudName/image/upload',
          ),
        )
          ..fields['upload_preset'] = uploadPreset
          ..fields['folder'] = 'sacny'
          ..files.add(
            http.MultipartFile.fromBytes(
              'file',
              imageBytes,
              filename: image.name,
            ),
          );

        final response = await request.send();
        final responseBody = await response.stream.bytesToString();

        if (response.statusCode != 200) {
          throw Exception(
            'فشل رفع الصورة ${image.name}: ${response.statusCode} $responseBody',
          );
        }

        final responseData = jsonDecode(responseBody) as Map<String, dynamic>;
        final secureUrl = responseData['secure_url'] as String?;

        if (secureUrl == null || secureUrl.isEmpty) {
          throw Exception('لم يُرجع Cloudinary رابط الصورة ${image.name}.');
        }

        imageUrls.add(secureUrl);
      }

      return imageUrls;
    } catch (error) {
      throw Exception('تعذر رفع الصور إلى Cloudinary: $error');
    }
  }
}