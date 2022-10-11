import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';
import 'package:stacked_services/stacked_services.dart';
import '../../../app/app.locator.dart';
import '../../../app/app.router.dart';

class UserMessageViewModel extends BaseViewModel {
  UserMessageViewModel() {
    getAllUser();
  }

  List<dynamic> displayList = [];

  final NavigationService _navigationService = locator<NavigationService>();

  void changeNavToRoute(String route, String id, String userName) {
    _navigationService.navigateTo(route,
        arguments: MessageViewScreenArguments(userId: id, userName: userName ));
  }

  CollectionReference students =
      FirebaseFirestore.instance.collection('messages');

  Future<void> getAllUser() async {
    try {
      setBusy(true);
      notifyListeners();
      QuerySnapshot data = await students.get();
      List<dynamic> result = data.docs.map((doc) {
        var data = doc.data() as Map<String, dynamic>;
        data.addAll({"id": doc.id});
        return data;
      }).toList();

      displayList = result;
      setBusy(false);
      notifyListeners();
    } catch (a) {
      // print("error" + a.toString());
    }
  }
}
