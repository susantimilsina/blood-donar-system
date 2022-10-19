import 'dart:convert';
import 'package:blood_doner/app/app.router.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart' as Service;
import '../../app/app.locator.dart';
import '../../services/authentication_service.dart';
import 'package:http/http.dart' as http;

class PatientViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final Service.NavigationService _navigationService =
      locator<Service.NavigationService>();

  TextEditingController purposeController = TextEditingController();
  double? latitude;
  double? longitude;

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

  String selectedBloodgroup = "A+";

  void onChangedBloodgroup(String? newBloodgroup) {
    selectedBloodgroup = newBloodgroup!;
    notifyListeners();
  }

  void changeNavToRoute(String route) {
    _navigationService.navigateTo(route,
        arguments: AboutUsViewArguments(fromPatient: true));
  }

  Future<void> performLogout() async {
    _authenticationService.signOut();
  }

  CollectionReference students =
      FirebaseFirestore.instance.collection('requests');

  Future<void> createDonation() async {
    setBusy(true);
    notifyListeners();
    await sendNotification();
    students.add({
      "blood_type": selectedBloodgroup.toString(),
      "date": Timestamp.now(),
      "purpose": purposeController.text.toString(),
      "userId": _authenticationService.firebaseUser!.uid
    }).then((value) async {
      Get.snackbar(
        "Success",
        "Blood Request send successfully to Admin",
        colorText: Colors.white,
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
      );
    }).catchError((error) {
      Get.snackbar(
        "Failed",
        "Donation History Addition Failed!!",
        colorText: Colors.white,
        backgroundColor: Colors.red,
        snackPosition: SnackPosition.BOTTOM,
      );
    });
    purposeController.text = "";
    selectedBloodgroup = "A+";
    setBusy(false);
    notifyListeners();
  }

  Future sendNotification() async {
    // purposeController -> Notification description
    // selectedBloodgroup -> Notification to those with this blood group

    const String serverToken =
        "AAAAJ_1Hx6E:APA91bEfyBWeWgRrNRRu6UInbILbuVOoNaLF_Asf4Y5X0BJJOSMbNgEuEibkumEkyrEtDYiyNoSUsI7k28Zg54bjiicukJYV8GQgrHgkMKa6V_5QxVE6Yjv1qqm_8wBsfSF57UuP5Lca";
    String title = "${_authenticationService.user?.userName} is need of blood";
    try {
      await http.post(
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json',
          'Authorization': 'key=$serverToken',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': purposeController.text,
              'title': title,
            },
            "data": {
              "click_action": "FLUTTER_NOTIFICATION_CLICK",
              'body': purposeController.text,
              'title': title,
            },
            'priority': 'high',
            'to': "/topics/admin",
          },
        ),
      );
    } catch (e) {
      print("Error=${e.toString()}");
    }
  }
}
