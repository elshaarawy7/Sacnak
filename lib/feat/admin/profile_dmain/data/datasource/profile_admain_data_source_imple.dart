import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dartz/dartz.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';
import 'package:sacny/core/error/fuiler.dart';
import 'package:sacny/feat/admin/profile_dmain/data/datasource/data_sourcse_profile_admain.dart';

class ProfileAdmainDataSourceImple extends ProfileAdmainDataSource {
  final FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // دالة مساعدة لرفع صورة البروفايل إلى Cloudinary
  Future<String> _uploadProfileImage(String imagePath) async {
    const cloudName = 'dghtbue90';
    const uploadPreset = 'sacny_preset';

    var request = http.MultipartRequest(
      'POST',
      Uri.parse('https://api.cloudinary.com/v1_1/$cloudName/image/upload'),
    );

    request.fields['upload_preset'] = uploadPreset;
    request.fields['folder'] = 'sacny/profiles';

    XFile file = XFile(imagePath);
    var bytes = await file.readAsBytes();
    request.files.add(
      http.MultipartFile.fromBytes('file', bytes, filename: file.name),
    );

    var response = await request.send();
    if (response.statusCode == 200) {
      var responseData = await response.stream.toBytes();
      var responseString = String.fromCharCodes(responseData);
      var jsonMap = jsonDecode(responseString);
      return jsonMap['secure_url'];
    } else {
      throw Exception('فشل رفع صورة البروفايل');
    }
  }

  @override
  Future<Either<Fuiler, String>> updateProfile(
    final String name,
    final String phone,
    final String? imagePath,
  ) async {
    try {
      final user = firebaseAuth.currentUser;
      if (user == null) {
        return Left(ServerFuiler("المستخدم غير مسجل الدخول"));
      }

      String profileImageUrl = '';

      // 1. رفع الصورة إلى Cloudinary إن وجدت
      if (imagePath != null && imagePath.isNotEmpty) {
        profileImageUrl = await _uploadProfileImage(imagePath);
      }

      // 2. تجهيز البيانات للتحديث في Firestore
      Map<String, dynamic> updateData = {
        'uid': user.uid,
        'name': name,
        'phone': phone,
        'updatedAt': FieldValue.serverTimestamp(),
      };

      if (profileImageUrl.isNotEmpty) {
        updateData['image'] = profileImageUrl;
      }

      // 3. حفظ البيانات في Firestore
      await firebaseFirestore
          .collection('admin_suers')
          .doc(user.uid)
          .set(updateData, SetOptions(merge: true));

      return const Right("تم تحديث البيانات بنجاح");
    } catch (e) {
      return Left(ServerFuiler(e.toString().replaceAll("Exception: ", "")));
    }
  }
}