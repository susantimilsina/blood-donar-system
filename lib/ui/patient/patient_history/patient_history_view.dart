import 'package:blood_doner/ui/patient/patient_history/patient_history_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class PatientHistoryView extends StatelessWidget {
  const PatientHistoryView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<PatientHistoryViewModel>.reactive(
        disposeViewModel:
            false, //so that we reuse the same viewmodel to maintain the state
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: const Text("Request History"),
              ),
              body: model.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: model.currentDataList.isEmpty
                          ? Center(
                              child: Text(
                                "No History found",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            )
                          : ListView.separated(
                              itemCount: model.currentDataList.length,
                              itemBuilder: (context, index) => Card(
                                elevation: 3,
                                child: ListTile(
                                  title: Text(
                                    'Date: ${model.currentDataList[index]['date']}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: Text(
                                    '${model.currentDataList[index]['blood_type']}',
                                    style: Theme.of(context)
                                        .textTheme
                                        .headline5!
                                        .copyWith(color: Colors.red),
                                  ),
                                  subtitle: Text(
                                    'Purpose: ${model.currentDataList[index]['purpose']}',
                                  ),
                                ),
                              ),
                              separatorBuilder:
                                  (BuildContext context, int index) {
                                return const SizedBox(height: 10);
                              },
                            ),
                    ),
            ),
        viewModelBuilder: () => PatientHistoryViewModel()
        //  locator<HomeViewModel>(),
        );
  }
}
