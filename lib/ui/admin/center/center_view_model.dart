import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';

import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';
import '../../../models/center_blood.dart';
import '../../../services/authentication_service.dart';

class CenterViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final NavigationService _navigationService = locator<NavigationService>();

  CenterViewModel() {
    getAllHistory();
  }

  List<BloodCenter> currentDataList = [];
  CollectionReference students =
      FirebaseFirestore.instance.collection('center');

  Future<void> getAllHistory() async {
    setBusy(true);
    notifyListeners();
    QuerySnapshot data = await students.get();
    List<dynamic> result = data.docs.map((doc) => doc.data()).toList();

    currentDataList = result.map((e) {
      return BloodCenter.fromJson(e);
    }).toList();
    setBusy(false);
    notifyListeners();
  }

  Future<void> changeNavToRoute(String route) async {
    await _authenticationService.changeRoute(route);
  }

  Future<void> changeNav(BloodCenter bloodCenter) async {
    await _navigationService.navigateTo(Routes.editCenterView,
        arguments: EditCenterViewArguments(bloodCenter: bloodCenter));
  }

  initialize() {
    getAllHistory();
  }

  Future deleteData(BloodCenter center) async {
    setBusy(true);
    notifyListeners();
    await students
        .where("name", isEqualTo: center.name.toString())
        .where("address", isEqualTo: center.address.toString())
        .get()
        .then(
          (QuerySnapshot snapshot) => {
            snapshot.docs.forEach((f) {
              students.doc(f.id).delete();
            }),
          },
        );
    getAllHistory();
    setBusy(false);
    notifyListeners();
  }
}
