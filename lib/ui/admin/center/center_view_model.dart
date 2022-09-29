import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:stacked/stacked.dart';

class CenterViewModel extends BaseViewModel {

  CenterViewModel() {
    getAllHistory();
  }

  List<dynamic> currentDataList = [];
  CollectionReference students =
      FirebaseFirestore.instance.collection('center');

  Future<void> getAllHistory() async {
    setBusy(true);
    notifyListeners();
    QuerySnapshot data = await students.get();
    List<dynamic> result = data.docs.map((doc) => doc.data()).toList();
    currentDataList = result;
    setBusy(false);
    notifyListeners();
  }
}
