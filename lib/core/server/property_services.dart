import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';

class PropertyServices {
  final FirebaseFirestore storage = FirebaseFirestore.instance; 
  final FirebaseFirestore firestore = FirebaseFirestore.instance; 
  final ImagePicker imagePicker = ImagePicker(); 

  Future<File?> pickImage() async {
    final pickedFile = await imagePicker.pickImage(
      source: ImageSource.gallery , 
      imageQuality: 50 ,
      );
    if (pickedFile != null) {
      return File(pickedFile.path);
    }
    return null;
  } 



  Future<void> uploadPropertyImages(List<File> images, String propertyId) async {
    for (var image in images) {
      final imageName = DateTime.now().millisecondsSinceEpoch.toString();
      final storageRef = storage.collection('property_images').doc(propertyId).collection('images').doc(imageName);
      await storageRef.set({
        'image_url': image.path,
        'uploaded_at': FieldValue.serverTimestamp(),
      });
    }
  } 


  Future<void> addProperty(Map<String, dynamic> propertyData) async {
    final propertyRef = firestore.collection('properties').doc();
    await propertyRef.set(propertyData);
  }

}