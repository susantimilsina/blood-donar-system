import 'package:blood_doner/app/app.locator.dart';
import 'package:blood_doner/app/app.logger.dart';
import 'package:blood_doner/app/app.router.dart';
import 'package:blood_doner/services/authentication_service.dart';
import 'package:blood_doner/services/firestore_service.dart';
import 'package:stacked/stacked.dart';

class HomeViewModel extends FutureViewModel {
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();
  final FirestoreService _firestoreService = locator<FirestoreService>();
  late List userList = [];
  late List displayList = [];
  final _log = getLogger('HomeView-Model');

  Future<void> filterWithBg(String bloodGroup) async {
    if (bloodGroup == "All") {
      displayList = userList;
    } else {
      displayList = userList
          .where((element) => element['bloodGroup'] == bloodGroup)
          .toList();
    }
    notifyListeners();
  }

  String dropdownvalue = 'All';

  void changeDDValue(String value) {
    dropdownvalue = value;
    filterWithBg(value);
    notifyListeners();
  }

  void changeNav() {
    _authenticationService.changeRoute(Routes.editProfileView);
  }

  Future<void> performLogout() async {
    _authenticationService.signOut();
  }

  @override
  Future futureToRun() async {
    userList = await _firestoreService.fetchAllUsers();
    displayList = [...userList];
    _log.i(userList);
    notifyListeners();
  }
}
