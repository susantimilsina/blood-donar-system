import 'package:animations/animations.dart';
import 'package:blood_doner/app/app.router.dart';
import 'package:blood_doner/models/center_blood.dart';
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
                actions: [
                  IconButton(
                      onPressed: () {
                        model
                            .changeNavToRoute(Routes.addCenterView)
                            .then((value) {
                          model.initialize();
                        });
                      },
                      icon: const Icon(Icons.add))
                ],
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
                                    model.currentDataList[index].bloods
                                        as List<Blood>),
                                closedBuilder:
                                    (context, VoidCallback openContainer) =>
                                        Dismissible(
                                  key: Key(model.currentDataList[index].name
                                      .toString()),
                                  onDismissed: (direction) {
                                    if (direction ==
                                        DismissDirection.startToEnd) {
                                      model.deleteData(
                                          model.currentDataList[index]);
                                    }
                                  },
                                  child: Card(
                                    elevation: 3,
                                    child: ListTile(
                                      onTap: openContainer,
                                      title: Text(
                                        'Name: ${model.currentDataList[index].name}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      subtitle: Text(
                                        'Address: ${model.currentDataList[index].address}',
                                        // style: Theme.of(context)
                                        //     .textTheme
                                        //     .headline5
                                      ),
                                      trailing: IconButton(
                                        icon: const Icon(Icons.edit),
                                        onPressed: () {
                                          model
                                              .changeNav(
                                                  model.currentDataList[index])
                                              .then((value) {
                                            model.initialize();
                                          });
                                        },
                                      ),
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
