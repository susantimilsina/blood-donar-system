import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

import '../../../app/app.locator.dart';
import '../../../services/firestore_service.dart';

class BloodRequestViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  BloodRequestViewModel() {
    getAllHistory();
  }

  List<Map<String, dynamic>> currentDataList = [];
  CollectionReference students =
      FirebaseFirestore.instance.collection('requests');

  Future<void> getAllHistory() async {
    setBusy(true);
    notifyListeners();
    List<Map<String, dynamic>> finalResult = [];
    QuerySnapshot data = await students.get();
    List<Map<String, dynamic>> result =
        data.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
    await Future.forEach(result, (Map<String, dynamic> element) async {
      Map<String, dynamic> data = {};
      data.addAll(element);
      var userData = await getUser(data["userId"]);
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
}
