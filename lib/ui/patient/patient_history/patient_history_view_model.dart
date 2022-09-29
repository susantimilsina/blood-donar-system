import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../services/authentication_service.dart';

class PatientHistoryViewModel extends BaseViewModel {
  PatientHistoryViewModel() {
    getAllHistory();
  }

  List<dynamic> currentDataList = [];
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
  }

  CollectionReference students =
      FirebaseFirestore.instance.collection('requests');

  Future<void> getAllHistory() async {
    setBusy(true);
    notifyListeners();
    QuerySnapshot data = await students.get();
    List<dynamic> result = data.docs.map((doc) => doc.data()).toList();
    currentDataList = result
        .where((e) => e["userId"] == _authenticationService.firebaseUser?.uid)
        .toList();
    setBusy(false);
    notifyListeners();
  }
}
