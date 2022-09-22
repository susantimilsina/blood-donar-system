import 'dart:convert';
import 'dart:math';
import 'package:blood_doner/app/app.locator.dart';
import 'package:blood_doner/app/app.router.dart';
import 'package:blood_doner/services/authentication_service.dart';
import 'package:blood_doner/services/firestore_service.dart';
import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;

class HomeViewModel extends FutureViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  late List<Map<String, dynamic>> userList = [];
  late List<Map<String, dynamic>> displayList = [];

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
    selectedBloodgroup = newBloodgroup ?? selectedBloodgroup;
    notifyListeners();
  }

  Future<void> filterWithBg() async {
    if (dropdownvalue == "All") {
      displayList = userList;
    } else {
      displayList = userList
          .where((element) => element['bloodGroup'] == dropdownvalue)
          .toList();
    }
    if (availableValue == "All") {
      displayList = displayList;
    } else if (availableValue == "Available") {
      displayList = displayList
          .where((element) => element["isAvailable"] == true)
          .toList();
    } else {
      displayList = displayList
          .where((element) => (element["isAvailable"] == false ||
              element["isAvailable"] == null))
          .toList();
    }
    notifyListeners();
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
    longitude = loc.latitude;
    notifyListeners();
  }

  String calculateDistance(lati, longi) {
    double lat2 = double.parse(lati ?? "0.0");
    double lon2 = double.parse(longi ?? "0.0");
    var p = 0.017453292519943295;
    var c = cos;
    var a = 0.5 -
        c((lat2 - (latitude ?? 0.0)) * p) / 2 +
        c((latitude ?? 0.0) * p) *
            c(lat2 * p) *
            (1 - c((lon2 - (longitude ?? 0.0)) * p)) /
            2;
    return (12742 * asin(sqrt(a))).toStringAsFixed(2);
  }

  String dropdownvalue = 'All';
  String availableValue = "All";

  void changeDDValue(String value) {
    dropdownvalue = value;
    filterWithBg();
    notifyListeners();
  }

  void changeDDAvailableValue(String value) {
    availableValue = value;
    filterWithBg();
    notifyListeners();
  }

  void changeNav() {
    _authenticationService.changeRoute(Routes.editProfileView);
  }

  Future<void> performLogout() async {
    _authenticationService.signOut();
  }

  Future sendNotification() async {
    //purposeController -> Notification description
    //selectedBloodgroup -> Notification to those with this blood group

    const String serverToken =
        "AAAAJ_1Hx6E:APA91bEfyBWeWgRrNRRu6UInbILbuVOoNaLF_Asf4Y5X0BJJOSMbNgEuEibkumEkyrEtDYiyNoSUsI7k28Zg54bjiicukJYV8GQgrHgkMKa6V_5QxVE6Yjv1qqm_8wBsfSF57UuP5Lca";
    String title = "${_authenticationService.user?.userName} is need of blood";
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
          'priority': 'high',
          'to': selectedBloodgroup.replaceAll("+", ""),
        },
      ),
    );
  }

  @override
  Future futureToRun() async {
    userList = await _firestoreService.fetchAllUsers();
    await _initLocationService();
    userList = userList
        .where((element) => element["role"].toString().toLowerCase() == "doner")
        .toList();
    displayList = [...userList];
    notifyListeners();
  }
}
