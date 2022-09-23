import 'dart:io';
import 'package:blood_doner/services/authentication_service.dart';
import 'package:blood_doner/services/cloud_storage_service.dart';
import 'package:blood_doner/services/firestore_service.dart';
import 'package:blood_doner/services/image_selector.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../app/app.locator.dart';
import '../shared/ui_helper.dart';

class EditProfileViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  final SnackbarService _snackbarService = locator<SnackbarService>();
  final BottomSheetService _bottomSheetService = locator<BottomSheetService>();
  final CloudStorageService _cloudStorageService =
      locator<CloudStorageService>();
  final ImageSelector _imageSelector = locator<ImageSelector>();

  TextEditingController usernameController = TextEditingController();
  XFile? pickedImage;
  bool? hasAvailable;

  String get getUserImageUrl {
    return _authenticationService.user!.imageUrl;
  }

  String get getUserName {
    return _authenticationService.user!.userName;
  }

  String get getRole {
    return _authenticationService.user!.role;
  }

  String get getUserAge {
    return _authenticationService.user!.age;
  }

  String get getUserMail {
    return _authenticationService.user!.email;
  }
  String get getUserRole {
    return _authenticationService.user!.role;
  }

  bool get getUserAvailability {
    return _authenticationService.user!.isAvailable;
  }

  void toggleAvailable() {
    hasAvailable = !(hasAvailable ?? false);
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

  Future<void> updateUserProfile({String? newuserName, String? newAge}) async {
    if ((newAge != null && int.parse(newAge) <= 0) ||
        (newuserName != null && newuserName.isEmpty)) {
      _snackbarService.showSnackbar(message: 'Please enter valid details');
      return;
    }
    setBusy(true);
    await _firestoreService.updateUser(
        uid: _authenticationService.firebaseUser!.uid,
        userModel: _authenticationService.user!.copyWith(
            userName: newuserName,
            age: newAge,
            isAvailable: hasAvailable ?? getUserAvailability));
    if (pickedImage != null) {
      await _cloudStorageService.deleteImage(
          imageFileName: _authenticationService.firebaseUser!.uid);
      await _cloudStorageService.uploadImage(
          imageToUpload: File(pickedImage!.path),
          title: _authenticationService.firebaseUser!.uid);
      imageCache.clear();
      imageCache.clearLiveImages();
    }
    await _authenticationService.populateUser(
        userId: _authenticationService.firebaseUser!.uid);
    setBusy(false);
    _snackbarService.showSnackbar(message: 'Profile updated successfully');
  }
}
