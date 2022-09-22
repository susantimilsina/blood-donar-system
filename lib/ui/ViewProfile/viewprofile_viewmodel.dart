import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:http/http.dart' as http;
import '../../app/app.locator.dart';
import '../../services/authentication_service.dart';

class ViewProfileViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  TextEditingController purposeController = TextEditingController();

  Future sendNotification(String selectedBloodgroup) async {
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
}
