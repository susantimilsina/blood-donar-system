import 'package:blood_doner/models/UserModel.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.locator.dart';
import '../../services/firestore_service.dart';

class OtherMessageViewModel extends BaseViewModel {
  final FirestoreService _firestoreService = locator<FirestoreService>();

  UserModel? user;

  getUser(String userId) async {
    setBusy(true);
    notifyListeners();
    if (await _firestoreService.isUserPresent(uid: userId)) {
      var data = await _firestoreService.getUser(uid: userId);
      user = data;
    }
    setBusy(false);
    notifyListeners();
  }
}
