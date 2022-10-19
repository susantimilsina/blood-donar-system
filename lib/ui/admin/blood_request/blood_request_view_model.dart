import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mailer/mailer.dart';
import 'package:mailer/smtp_server/gmail.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/firestore_service.dart';

class BloodRequestViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  BloodRequestViewModel() {
    getAllHistory();
  }
  TextEditingController titleCon = TextEditingController();
  TextEditingController descriptionCon = TextEditingController();

  List<Map<String, dynamic>> currentDataList = [];
  CollectionReference students =
      FirebaseFirestore.instance.collection('requests');

  Future<void> getAllHistory() async {
    setBusy(true);
    notifyListeners();
    List<Map<String, dynamic>> finalResult = [];
    QuerySnapshot data = await students.orderBy("date", descending: true).get();
    List<Map<String, dynamic>> result =
        data.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    await Future.forEach(result, (Map<String, dynamic> element) async {
      Map<String, dynamic> data = {};
      data.addAll(element);
      var userData = await getUser(data["userId"]);
      userData.removeWhere((key, value) => key == "date");
      data.addAll(userData);
      finalResult.add(data);
    });
    currentDataList = finalResult;
    setBusy(false);
    notifyListeners();
  }

  Future<dynamic> getUser(String userId) async {
    if (await _firestoreService.isUserPresent(uid: userId)) {
      var data = await _firestoreService.getUser(uid: userId);
      return data.toMap();
    } else {
      return {};
    }
  }

  Future<void> addNotification(String mail) async {
    setBusy(true);
    notifyListeners();
    var userData = await getUser(mail);

    String username = 'donateblood.bdh1@gmail.com';
    String password = 'zsffdkbrugavargj';

    final smtpServer = gmail(username, password);
    final message = Message()
      ..from = Address(username, 'Blood Hub')
      ..recipients.add(userData["email"].toString())
      ..subject = titleCon.text
      ..text = descriptionCon.text;

    try {
      final sendReport = await send(message, smtpServer);
      Get.snackbar(
        "Success",
        "Notification Send Successfully",
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
    } on MailerException catch (e) {
      for (var p in e.problems) {
        log('Problem: ${p.code}: ${p.msg}');
      }

      Get.snackbar(
        "Failed",
        "Notification Send Failed!!",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    }
    titleCon.text = "";
    descriptionCon.text = "";
    setBusy(false);
    notifyListeners();
  }
}
