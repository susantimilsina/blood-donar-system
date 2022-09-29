import 'package:blood_doner/models/UserModel.dart';
import 'package:stacked/stacked.dart';

import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../services/authentication_service.dart';
import '../../services/firestore_service.dart';

class AdminViewModel extends BaseViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  AdminViewModel() {
    getAllUsers();
  }

  String selectedBloodgroup = "A+";
  String dropdownvalue = 'All';
  String availableValue = "All";
  final FirestoreService _firestoreService = locator<FirestoreService>();

  String userValue = "Donor";
  late List<UserModel> userList = [];
  late List<UserModel> donorList = [];
  late List<UserModel> patientList = [];

  void onChangedBloodgroup(String? newBloodgroup) {
    selectedBloodgroup = newBloodgroup ?? selectedBloodgroup;
    notifyListeners();
  }

  void changeDDValue(String value) {
    dropdownvalue = value;
    filterDonor();
    notifyListeners();
  }

  void changeUserValue(String value) {
    userValue = value;
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
    patientList = list
        .where(
            (element) => (element.role.toString().toLowerCase() == "patient"))
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
                (e.bloodGroup == selectedBloodgroup) &&
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
            userList.where((e) => e.bloodGroup == selectedBloodgroup).toList();
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

  Future<void> performLogout() async {
    _authenticationService.signOut();
  }
}
