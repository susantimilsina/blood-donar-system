import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.locator.dart';
import '../../services/authentication_service.dart';
import '../../services/firestore_service.dart';

class DonateFormViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  DateTime selectedDate = DateTime.now();
  TextEditingController pints = TextEditingController();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  CollectionReference students =
      FirebaseFirestore.instance.collection('donations');
  String dropdownvalue = "";
  List<String> dropdownList = [];

  DonateFormViewModel() {
    getDropdownList();
  }

  Future<void> createDonation(bool isLess) async {
    setBusy(true);
    notifyListeners();
    students.add({
      "center": dropdownvalue,
      "date": "${selectedDate.toLocal()}".split(' ')[0],
      "pints": pints.text.toString(),
      "userId": _authenticationService.firebaseUser!.uid
    }).then((value) async {
      Get.snackbar(
        "Success",
        "Donation History inserted Successfully",
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
      if (isLess) {
        await _firestoreService.updateUser(
            uid: _authenticationService.firebaseUser!.uid,
            userModel:
                _authenticationService.user!.copyWith(isAvailable: false));
      }
    }).catchError((error) {
      Get.snackbar(
        "Failed",
        "Donation History Addition Failed!!",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    });
    setBusy(false);
    notifyListeners();
  }

  changeSelectedDate(DateTime data) {
    selectedDate = data;
    notifyListeners();
  }

  void changeDDValue(String value) {
    dropdownvalue = value;
    notifyListeners();
  }

  Future<void> getDropdownList() async {
    CollectionReference students =
        FirebaseFirestore.instance.collection('center');
    setBusy(true);
    notifyListeners();
    QuerySnapshot data = await students.get();
    List<String> result =
        data.docs.map((doc) => doc["name"].toString()).toList();
    dropdownList = result;
    dropdownvalue = dropdownList[0];
    setBusy(false);
    notifyListeners();
  }
}
