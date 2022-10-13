import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../models/UserModel.dart';
import '../../../services/authentication_service.dart';
import '../../../services/firestore_service.dart';

class NotificationViewModel extends BaseViewModel {
  NotificationViewModel() {
    getAllUsers();
  }
  String dropdownvalue = 'All';
  String availableValue = "All";
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  final FirestoreService _firestoreService = locator<FirestoreService>();

  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  late List<UserModel> userList = [];
  late List<UserModel> donorList = [];

  void changeDDValue(String value) {
    dropdownvalue = value;
    filterDonor();
    notifyListeners();
  }

  void changeNav(String nav) {
    _authenticationService.changeRoute(nav);
  }

  void changeDDAvailableValue(String value) {
    availableValue = value;
    filterDonor();
    notifyListeners();
  }

  CollectionReference students =
      FirebaseFirestore.instance.collection('notification');

  Future<void> addNotification() async {
    setBusy(true);
    notifyListeners();
    String username = 'donateblood.bdh1@gmail.com';
    String password = 'zsffdkbrugavargj';

    final smtpServer = gmail(username, password);
    await Future.forEach(donorList, (UserModel element) async {
      final message = Message()
        ..from = Address(username, 'Blood Hub')
        ..recipients.add(element.email)
        ..subject = titleController.text
        ..text = descriptionController.text;

      try {
        final sendReport = await send(message, smtpServer);
        log('Message sent: ' + sendReport.toString());
      } on MailerException catch (e) {
        log('Message not sent.' + e.message.toString());
        for (var p in e.problems) {
          log('Problem: ${p.code}: ${p.msg}');
        }
      }
    });
    students.add({
      "bloodgroup": dropdownvalue,
      "user": "donor",
      "title": titleController.text,
      "description": descriptionController.text,
      "time": Timestamp.now()
    }).then((value) async {
      Get.snackbar(
        "Success",
        "Notification Send Successfully",
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
    }).catchError((error) {
      Get.snackbar(
        "Failed",
        "Notification Send Failed!!",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    });
    setBusy(false);
    notifyListeners();
  }

  getAllUsers() async {
    setBusy(true);
    notifyListeners();
    var data = await _firestoreService.fetchAllUsers();
    List<UserModel> list = data.map((e) => UserModel.fromMap(e)).toList();
    userList = list;
    donorList = list
        .where((element) => (element.role.toString().toLowerCase() == "doner" ||
            element.role.toString().toLowerCase() == "donor"))
        .toList();
    setBusy(false);
    notifyListeners();
  }

  filterDonor() {
    if (dropdownvalue.toString().toLowerCase() != "all" &&
        availableValue.toString().toLowerCase() != "all") {
      if (dropdownvalue.toString().toLowerCase() == "rare blood") {
        donorList = userList
            .where((e) =>
                (e.bloodGroup == "AB-" ||
                    e.bloodGroup == "B-" ||
                    e.bloodGroup == "AB+" ||
                    e.bloodGroup == "A-") &&
                e.isAvailable ==
                    (availableValue.toLowerCase() == "available"
                        ? true
                        : false))
            .toList();
      } else {
        donorList = userList
            .where((e) =>
                (e.bloodGroup == dropdownvalue) &&
                e.isAvailable ==
                    (availableValue.toLowerCase() == "available"
                        ? true
                        : false))
            .toList();
      }
      notifyListeners();
    } else if (dropdownvalue.toString().toLowerCase() == "all" &&
        availableValue.toString().toLowerCase() == "all") {
      donorList = userList;
      notifyListeners();
    } else if (dropdownvalue.toString().toLowerCase() == "all") {
      donorList = userList
          .where((e) =>
              e.isAvailable ==
              (availableValue.toLowerCase() == "available" ? true : false))
          .toList();
      notifyListeners();
    } else if (availableValue.toString().toLowerCase() == "all") {
      if (dropdownvalue.toString().toLowerCase() == "rare blood") {
        donorList = userList
            .where((e) => (e.bloodGroup == "AB-" ||
                e.bloodGroup == "B-" ||
                e.bloodGroup == "AB+" ||
                e.bloodGroup == "A-"))
            .toList();
      } else {
        donorList =
            userList.where((e) => e.bloodGroup == dropdownvalue).toList();
      }
      notifyListeners();
    } else {
      donorList = userList
          .where((element) =>
              (element.role.toString().toLowerCase() == "doner" ||
                  element.role.toString().toLowerCase() == "donor"))
          .toList();
      notifyListeners();
    }
  }
}
