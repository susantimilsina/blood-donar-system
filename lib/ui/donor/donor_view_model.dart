import 'dart:developer';

import 'package:analyzer/dart/ast/token.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../models/donationModel.dart';
import '../../services/authentication_service.dart';
import '../component/toast.dart';

class DonorViewModel extends BaseViewModel {
  DonorViewModel() {
    setupFirebaseMessage();
    getAllDontion();
  }
  List<DonationModel> currentDataList = [];
  List<DonationModel> displayList = [];
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  void changeNav() {
    _authenticationService.changeRoute(Routes.editProfileView);
  }

  Future<void> changeNavForm() async {
    await _authenticationService.changeRoute(Routes.donateFormView);
  }

  Future<void> performLogout() async {
    _authenticationService.signOut();
    unsubscribeToTopic();
  }

  Future<void> setupFirebaseMessage() async {
    subscribeToTopic();
    RemoteMessage? initialMessage =
        await FirebaseMessaging.instance.getInitialMessage();
    if (initialMessage != null) {
      print("Message her");
    }
    FirebaseMessaging.instance.getToken().then((value) {
      print("Toke" + value.toString());
    });
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String title = message.data['title'] ?? message.notification?.title ?? "";
      String body = message.data['body'] ?? message.notification?.body ?? "";
      log("Titel" + title.toString());
      log("body" + body.toString());
      ToastComponent.toast("$title \n$body");
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("Remote" + message.toString());
    });
  }

  CollectionReference students =
      FirebaseFirestore.instance.collection('donations');

  Future<void> getAllDontion() async {
    setBusy(true);
    notifyListeners();
    QuerySnapshot data = await students.get();
    List<dynamic> result = data.docs.map((doc) => doc.data()).toList();
    List<DonationModel> dataList =
        result.map((e) => DonationModel.fromMap(e)).toList();
    currentDataList = dataList;
    displayList = dataList;
    setBusy(false);
    notifyListeners();
  }

  @override
  Future futureToRun() async {
    getAllDontion();
  }

  subscribeToTopic() async {
    String userMail = (_authenticationService.user?.email ?? "")
        .replaceAll("@", "")
        .replaceAll(".", "");

    String bloodGroup = _authenticationService.user?.bloodGroup ?? "";

    await FirebaseMessaging.instance.subscribeToTopic(userMail);
    await FirebaseMessaging.instance
        .subscribeToTopic(bloodGroup.replaceAll("+", ""));
  }

  unsubscribeToTopic() async {
    String userMail = (_authenticationService.user?.email ?? "")
        .replaceAll("@", "")
        .replaceAll(".", "");
    String bloodGroup = _authenticationService.user?.bloodGroup ?? "";
    Future.microtask(() async {
      await FirebaseMessaging.instance.unsubscribeFromTopic(userMail);
      await FirebaseMessaging.instance
          .unsubscribeFromTopic(bloodGroup.replaceAll("+", ""));
    });
  }
}

Future<void> _firebaseMessagingBackgroundHandler(message) async {}
