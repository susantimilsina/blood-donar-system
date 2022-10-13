import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.locator.dart';
import '../../app/app.router.dart';
import '../../models/donationModel.dart';
import '../../services/authentication_service.dart';

class DonorViewModel extends BaseViewModel {
  DonorViewModel() {
    getAllDontion();
  }
  void initialize() {
    getAllDontion();
  }

  List<DonationModel> currentDataList = [];
  List<DonationModel> displayList = [];
  final AuthenticationService _authenticationService =
      locator<AuthenticationService>();

  void changeNav() {
    _authenticationService.changeRoute(Routes.editProfileView);
  }
  void changeNavToRoute(String route) {
    _authenticationService.changeRoute(route);
  }

  Future<void> changeNavForm() async {
    await _authenticationService.changeRoute(Routes.donateFormView);
  }

  Future<void> performLogout() async {
    _authenticationService.signOut();
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
    displayList = dataList
        .where((element) =>
            element.userId == _authenticationService.firebaseUser!.uid)
        .toList();
    setBusy(false);
    notifyListeners();
  }

  @override
  Future futureToRun() async {
    getAllDontion();
  }


}

