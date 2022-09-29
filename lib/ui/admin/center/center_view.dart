import 'dart:developer';

import 'package:animations/animations.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../blood_card/blood_card_view.dart';
import 'center_view_model.dart';

class CenterView extends StatelessWidget {
  const CenterView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CenterViewModel>.reactive(
        disposeViewModel:
            false, //so that we reuse the same viewmodel to maintain the state
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: const Text("Blood Donation Center"),
              ),
              body: model.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: model.currentDataList.isEmpty
                          ? Center(
                              child: Text(
                                "No Blood Center found",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            )
                          : ListView.separated(
                              itemCount: model.currentDataList.length,
                              itemBuilder: (context, index) => OpenContainer(
                                transitionDuration: const Duration(seconds: 1),
                                openBuilder: (context, action) => BloodCardView(
                                    model.currentDataList[index]['bloods']
                                        as List<dynamic>),
                                closedBuilder:
                                    (context, VoidCallback openContainer) =>
                                        Card(
                                  elevation: 3,
                                  child: ListTile(
                                    onTap: openContainer,
                                    title: Text(
                                      'Name: ${model.currentDataList[index]['name']}',
                                      style: const TextStyle(
                                          fontWeight: FontWeight.bold),
                                    ),
                                    subtitle: Text(
                                      'Address: ${model.currentDataList[index]['address']}',
                                      // style: Theme.of(context)
                                      //     .textTheme
                                      //     .headline5
                                    ),
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
        viewModelBuilder: () => CenterViewModel()
        //  locator<HomeViewModel>(),
        );
  }
}
