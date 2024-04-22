import 'package:device_info_plus/device_info_plus.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class AddProductImagesController extends GetxController {
  final ImagePicker _picker = ImagePicker();
  RxList<XFile> selectedImages = <XFile>[].obs;
  final RxList<String> arrImagesUrl = <String>[].obs;
  final FirebaseStorage storageRef = FirebaseStorage.instance;

  get selectedIamges => null;

  Future<void> showImagesPickerDialog() async {
    PermissionStatus status;

    DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();
    AndroidDeviceInfo androidDeviceInfo = await deviceInfo.androidInfo;

    if (androidDeviceInfo.version.sdkInt <= 32) {
      status = await Permission.storage.request();
    } else {
      status = await Permission.mediaLibrary.request();
    }

    if (status == PermissionStatus.granted) {
      Get.defaultDialog(
        title: "Choose Image",
        middleText: "Pick an image from the camera or gallery?",
        actions: [
          ElevatedButton(
            onPressed: () {
              Get.back();
              selectImages("camera");
            },
            child: Text('Camera'),
          ),
          ElevatedButton(
            onPressed: () {
              Get.back();
              selectImages("gallery");
            },
            child: Text('Gallery'),
          ),
        ],
      );
    } else if (status == PermissionStatus.denied || status == PermissionStatus.permanentlyDenied) {
      print("Error: Please allow permission for further usage");
      openAppSettings();
    }
  }

  Future<void> selectImages(String type) async {
    List<XFile> imgs = [];

    try {
      if (type == 'gallery') {
        imgs = await _picker.pickMultiImage(imageQuality: 80);
      } else {
        final img = await _picker.pickImage(source: ImageSource.camera, imageQuality: 80);
        if (img != null) {
          imgs.add(img);
        }
      }

      if (imgs.isNotEmpty) {
        selectedImages.addAll(imgs);
        print(selectedImages.length);
      }
    } catch (e) {
      print('Error: $e');
    } finally {
      update();
    }
  }

  void removeImage(int index) {
    selectedImages.removeAt(index);
    update();
  }

  void removeImages(int index) {}
}
