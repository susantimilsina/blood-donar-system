import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../EditProfile/edit_profile_viewmodel.dart';
import 'donor_view_model.dart';

// ignore: must_be_immutable
class DonorView extends StatelessWidget {
  const DonorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DonorViewModel>.reactive(
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
          body: Container()),
      viewModelBuilder: () => DonorViewModel(),
    );
  }
}
