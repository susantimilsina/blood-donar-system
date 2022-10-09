import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.router.dart';
import '../EditProfile/edit_profile_viewmodel.dart';
import 'donor_view_model.dart';

// ignore: must_be_immutable
class DonorView extends StatelessWidget {
  const DonorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DonorViewModel>.reactive(
      disposeViewModel: true,
      builder: (context, model, child) => Scaffold(
        appBar: AppBar(
          title: const Text("Blood Bank"),
        ),
        drawer: ViewModelBuilder<EditProfileViewModel>.reactive(
          builder: (context, insidemodel, child) => Drawer(
            child: ListView(
              // Important: Remove any padding from the ListView.
              padding: EdgeInsets.zero,
              children: [
                UserAccountsDrawerHeader(
                  // <-- SEE HERE
                  accountName: Text(
                    insidemodel.getUserName.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  accountEmail: Text(
                    insidemodel.getUserMail.toString(),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  currentAccountPicture: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    backgroundImage: NetworkImage(
                      insidemodel.getUserImageUrl,
                    ),
                  ),
                ),
                ListTile(
                  leading: const Icon(
                    Icons.edit,
                  ),
                  title: const Text('Edit Profile'),
                  onTap: () {
                    Navigator.pop(context);
                    model.changeNav();
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.add,
                  ),
                  title: const Text('Add a history'),
                  onTap: () {
                    Navigator.pop(context);
                    model.changeNavForm().then((value) {
                      model.initialize();
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.info_outline_rounded,
                  ),
                  title: const Text('About Us'),
                  onTap: () {
                    Navigator.pop(context);
                    model.changeNavToRoute(Routes.aboutUsView);
                  },
                ),
                ListTile(
                  leading: const Icon(
                    Icons.logout,
                  ),
                  title: const Text('Logout'),
                  onTap: () {
                    Navigator.pop(context);
                    model.performLogout();
                  },
                ),
              ],
            ),
          ),
          viewModelBuilder: () => EditProfileViewModel(),
        ),
        body: model.isBusy
            ? const Center(child: CircularProgressIndicator())
            : Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: RefreshIndicator(
                      onRefresh: model.futureToRun,
                      // showChildOpacityTransition: false,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 8.0, right: 8.0, bottom: 8.0),
                        child: ListView.separated(
                          itemCount: model.displayList.length,
                          itemBuilder: (context, index) => Card(
                            elevation: 3,
                            child: ListTile(
                              title: Text(
                                model.displayList[index].donatedDate.toString(),
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              subtitle: Text(
                                model.displayList[index].center,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              trailing: Column(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    model.displayList[index].pints,
                                    style: const TextStyle(
                                        fontSize: 20,
                                        fontWeight: FontWeight.bold),
                                  ),
                                  const Text(
                                    "PINTS",
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(height: 10);
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
      ),
      viewModelBuilder: () => DonorViewModel(),
    );
  }
}
