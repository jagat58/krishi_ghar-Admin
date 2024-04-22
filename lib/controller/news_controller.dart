// news_controller.dart

import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;
import 'package:image_picker/image_picker.dart';

class NewsController {
  final ImagePicker _picker = ImagePicker();

  Future<XFile?> pickImage() async {
    final XFile? pickedFile = await _picker.pickImage(source: ImageSource.gallery);
    return pickedFile;
  }

  Future<String?> uploadImageToFirebaseStorage(XFile imageFile) async {
    firebase_storage.Reference ref = firebase_storage.FirebaseStorage.instance
        .ref()
        .child('news_images')
        .child('${DateTime.now().millisecondsSinceEpoch}.jpg');

    await ref.putFile(File(imageFile.path));

    String downloadURL = await ref.getDownloadURL();
    return downloadURL;
  }

  Future<void> uploadNewsData({
    required String headline,
    required String newsDescription,
    required XFile pickedImage,
    required Function onSuccess,
    required Function(String) onError,
  }) async {
    String? imageURL = await uploadImageToFirebaseStorage(pickedImage);

    if (imageURL == null) {
      onError('Failed to upload image to Firebase Storage');
      return;
    }

    FirebaseFirestore.instance.collection('news').add({
      'headline': headline,
      'NewsD': newsDescription,
      'imageURL': imageURL,
      'date': Timestamp.now(),
    }).then((value) {
      onSuccess();
    }).catchError((error) {
      onError('Failed to upload news: $error');
    });
  }
}
