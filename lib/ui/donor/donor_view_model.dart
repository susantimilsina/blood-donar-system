import 'dart:developer';

import 'package:analyzer/dart/ast/token.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../services/authentication_service.dart';

class DonorViewModel extends BaseViewModel {
  DonorViewModel() {
    setupFirebaseMessage();
  }
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  void changeNav() {
    _authenticationService.changeRoute(Routes.editProfileView);
  }

  Future<void> performLogout() async {
    _authenticationService.signOut();
    unsubscribeToTopic();
  }

  Future<void> setupFirebaseMessage() async {
    subscribeToTopic();
    // RemoteMessage? initialMessage =
    //     await FirebaseMessaging.instance.getInitialMessage();
    FirebaseMessaging.instance.getToken().then((value) {
      print("Toke" + value.toString());
    });

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      String title = message.data['title'] ?? message.notification?.title ?? "";
      String body = message.data['body'] ?? message.notification?.body ?? "";
      log("Titel" + title.toString());
      log("body" + body.toString());
    });
    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      log("Remote" + message.toString());
    });
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
