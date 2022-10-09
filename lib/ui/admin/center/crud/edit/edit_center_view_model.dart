import 'package:blood_doner/models/center_blood.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';

class EditCenterViewModel extends BaseViewModel {
  TextEditingController addressController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController apController = TextEditingController(text: "0");
  TextEditingController anController = TextEditingController(text: "0");
  TextEditingController opController = TextEditingController(text: "0");
  TextEditingController onController = TextEditingController(text: "0");
  TextEditingController bpController = TextEditingController(text: "0");
  TextEditingController bnController = TextEditingController(text: "0");
  TextEditingController abpController = TextEditingController(text: "0");
  TextEditingController abnController = TextEditingController(text: "0");

  CollectionReference students =
      FirebaseFirestore.instance.collection('center');
  BloodCenter bloodcenter = BloodCenter();
  checkData(center) {
    bloodcenter = center;
    notifyListeners();
    for (var element in (center.bloods ?? [])) {
      if (element.bloodType.toString() == "A+") {
        apController.text = element.pints.toString();
      } else if (element.bloodType.toString() == "O+") {
        opController.text = element.pints.toString();
      } else if (element.bloodType.toString() == "AB+") {
        abpController.text = element.pints.toString();
      } else if (element.bloodType.toString() == "B+") {
        bpController.text = element.pints.toString();
      } else if (element.bloodType.toString() == "A-") {
        anController.text = element.pints.toString();
      } else if (element.bloodType.toString() == "B-") {
        bnController.text = element.pints.toString();
      } else if (element.bloodType.toString() == "AB-") {
        abnController.text = element.pints.toString();
      } else if (element.bloodType.toString() == "O-") {
        onController.text = element.pints.toString();
      }
    }
    addressController.text = center.address.toString();
    nameController.text = center.name.toString();
    notifyListeners();
  }

  editCenter() async {
    if (addressController.text.isEmpty || nameController.text.isEmpty) {
      Get.snackbar(
        "Empty Fields",
        "Some fields are empty!!",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    } else {
      try {
        setBusy(true);
        notifyListeners();
        BloodCenter bloodCenter = BloodCenter(bloods: []);
        bloodCenter.address = addressController.text.toString();
        bloodCenter.name = nameController.text.toString();
        bloodCenter.bloods!.addAll([
          Blood(
              bloodType: "A+", pints: int.parse(apController.text.toString())),
          Blood(
              bloodType: "A-", pints: int.parse(anController.text.toString())),
          Blood(
              bloodType: "O+", pints: int.parse(opController.text.toString())),
          Blood(
              bloodType: "O-", pints: int.parse(onController.text.toString())),
          Blood(
              bloodType: "B+", pints: int.parse(bpController.text.toString())),
          Blood(
              bloodType: "B-", pints: int.parse(bnController.text.toString())),
          Blood(
              bloodType: "AB+",
              pints: int.parse(abpController.text.toString())),
          Blood(
              bloodType: "AB-",
              pints: int.parse(abnController.text.toString())),
        ]);
        await students
            .where("name", isEqualTo: bloodcenter.name.toString())
            .where("address", isEqualTo: bloodcenter.address.toString())
            .get()
            .then(
              (QuerySnapshot snapshot) => {
                snapshot.docs.forEach((f) {
                  students.doc(f.id).update(bloodCenter.toJson()).then((value) {
                    clearAll();
                    Get.snackbar(
                      "Success",
                      "Blood center inserted Successfully",
                      colorText: Colors.white,
                      backgroundColor: Colors.green,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  }).catchError((error) {
                    Get.snackbar(
                      "Failed",
                      "Blood Center Edition Failed!!",
                      colorText: Colors.white,
                      backgroundColor: Colors.red,
                      snackPosition: SnackPosition.BOTTOM,
                    );
                  });
                  ;
                }),
              },
            );

        setBusy(false);
        notifyListeners();
      } catch (e) {
        setBusy(false);
        notifyListeners();
      }
    }
  }

  clearAll() {
    addressController.text = "";
    nameController.text = "";
    apController.text = "0";
    anController.text = "0";
    opController.text = "0";
    onController.text = "0";
    bpController.text = "0";
    bnController.text = "0";
    abpController.text = "0";
    abnController.text = "0";
    notifyListeners();
  }
}
