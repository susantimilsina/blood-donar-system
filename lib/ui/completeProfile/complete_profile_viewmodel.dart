import 'dart:io';

import 'package:blood_doner/app/app.logger.dart';
import 'package:blood_doner/services/cloud_storage_service.dart';
import 'package:blood_doner/services/firestore_service.dart';
import 'package:blood_doner/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:location/location.dart';
import 'package:logger/logger.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.locator.dart';
import '../../models/UserModel.dart';
import '../../services/authentication_service.dart';
import '../../services/image_selector.dart';

class CompleteProfileViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  final Logger _log = getLogger('CompleteProfileViewModel');
  final bgList = [
    const DropdownMenuItem(
      value: "A+",
      child: Center(child: Text('A+')),
    ),
    const DropdownMenuItem(
      value: "A-",
      child: Center(child: Text('A-')),
    ),
    const DropdownMenuItem(
      value: "B+",
      child: Center(child: Text('B+')),
    ),
    const DropdownMenuItem(
      value: "B-",
      child: Center(child: Text('B-')),
    ),
    const DropdownMenuItem(
      value: "AB+",
      child: Center(child: Text('AB+')),
    ),
    const DropdownMenuItem(
      value: "AB-",
      child: Center(child: Text('AB-')),
    ),
    const DropdownMenuItem(
      value: "O+",
      child: Center(child: Text('O+')),
    ),
    const DropdownMenuItem(
      value: "O-",
      child: Center(child: Text('O-')),
    ),
  ];
  final roleList = [
    const DropdownMenuItem(
      value: "Donor",
      child: Center(
        child: Text('Donor'),
      ),
    ),
    const DropdownMenuItem(
      value: 'Patient',
      child: Center(
        child: Text('Patient'),
      ),
    ),
  ];
  TextEditingController nameController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  String selectedRole = "Donor";
  String selectedBloodgroup = "A+";
  bool isAvailable = true;
  XFile? pickedImage;
  double? latitude;
  double? longitude;

  void toggleAvailable() {
    isAvailable = !isAvailable;
    notifyListeners();
  }

  void onChangedBloodgroup(String? newBloodgroup) {
    selectedBloodgroup = newBloodgroup ?? selectedBloodgroup;
    notifyListeners();
  }

  void onChangedPurpose(String? newRole) {
    selectedRole = newRole ?? selectedRole;
    notifyListeners();
  }

  void selectImage() async {
    Get.bottomSheet(
        Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            verticalSpaceMedium,
            const Padding(
              padding: EdgeInsets.only(left: 10.0),
              child: Text("Upload Image from :",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600)),
            ),
            verticalSpaceSmall,
            ListTile(
              onTap: () async {
                pickedImage = await _imageSelector.pickImagefromCamera();
                notifyListeners();
                Get.back();
              },
              leading: const Icon(Icons.camera),
              title: const Text("Camera"),
            ),
            ListTile(
              onTap: () async {
                pickedImage = await _imageSelector.pickImagefromGallery();
                notifyListeners();
                Get.back();
              },
              leading: const Icon(Icons.photo),
              title: const Text("Gallery"),
            ),
          ],
        ),
        backgroundColor: Colors.white);
  }

  Future _initLocationService() async {
    var location = Location();
    if (!await location.serviceEnabled()) {
      if (!await location.requestService()) {
        return;
      }
    }
    var permission = await location.hasPermission();
    if (permission == PermissionStatus.denied) {
      permission = await location.requestPermission();
      if (permission != PermissionStatus.granted) {
        return;
      }
    }

    var loc = await location.getLocation();
    latitude = loc.latitude;
    longitude = loc.longitude;
    notifyListeners();
  }

  void createUserinDb() async {
    if (nameController.text.isEmpty ||
        ageController.text.isEmpty ||
        pickedImage == null) {
      Get.snackbar("Empty Fields", "Please enter all the fields",
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
          backgroundColor: Colors.red);
      return;
    }
    setBusy(true);
    await _initLocationService();
    try {
      CloudStorageResult cloudStorageResult =
          await _cloudStorageService.uploadImage(
              imageToUpload: File(pickedImage!.path),
              title: _authenticationService.firebaseUser!.uid);

      final user = UserModel(
          userName: nameController.text.trim(),
          email: _authenticationService.firebaseUser!.email!,
          bloodGroup: selectedRole == "Donor" ? selectedBloodgroup : "",
          age: ageController.text.trim(),
          role: selectedRole,
          imageUrl: cloudStorageResult.imageUrl,
          longitude: (longitude ?? 0.0).toString(),
          latitude: (latitude ?? 0.0).toString(),
          imageFileName: cloudStorageResult.imageFileName,
          isAvailable: selectedRole.toString().toLowerCase().startsWith("d")
              ? isAvailable
              : false);

      await _firestoreService.createNewUserEntry(
          uid: _authenticationService.firebaseUser!.uid, user: user);
      await _authenticationService.populateUser(
          userId: _authenticationService.firebaseUser!.uid);
      Get.snackbar(
        "Success",
        "Log-in successful",
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
    } catch (e) {
      Get.snackbar("Error", "Some error occurred",
          colorText: Colors.white, backgroundColor: Colors.green);

      _log.e(e.toString());
    }
    setBusy(false);
  }
}
