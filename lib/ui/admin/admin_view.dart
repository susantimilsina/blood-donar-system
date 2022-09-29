import 'package:blood_doner/ui/admin/admin_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.router.dart';
import '../EditProfile/edit_profile_viewmodel.dart';
import '../shared/ui_helper.dart';

class AdminView extends StatelessWidget {
  const AdminView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    var items = [
      'All',
      "Rare Blood",
      'A+',
      'A-',
      'B+',
      'B-',
      'AB+',
      'AB-',
      'O+',
      'O-'
    ];
    var userValues = ["Donor", "Patient"];
    var availablityWise = ['All', 'Available', 'Unavaiable'];
    return ViewModelBuilder<AdminViewModel>.reactive(
        disposeViewModel:
            false, //so that we reuse the same viewmodel to maintain the state
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: const Text("Blood Donors List"),
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
                          "${insidemodel.getUserMail.toString()} (${insidemodel.getRole})",
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
                          Icons.house_sharp,
                        ),
                        title: const Text('Center'),
                        onTap: () {
                          Navigator.pop(context);
                          model.changeNav(Routes.centerView);
                        },
                      ),
                      ListTile(
                        leading: const Icon(
                          Icons.edit,
                        ),
                        title: const Text('Blood Request'),
                        onTap: () {
                          Navigator.pop(context);
                          model.changeNav(Routes.bloodRequestView);
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
                        const SizedBox(
                          height: 10,
                        ),
                        Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      "User Type",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Visibility(
                                    visible: model.userValue == "Donor",
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        "Blood Group",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Visibility(
                                    visible: model.userValue == "Donor",
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 8.0),
                                      child: Text(
                                        "Availability",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline6,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            verticalSpaceSmall,
                            Row(
                              children: [
                                Expanded(
                                  child: Container(
                                      height: 40,
                                      padding: const EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(30.0),
                                        border: Border.all(
                                            color: Colors.grey,
                                            style: BorderStyle.solid,
                                            width: 0.80),
                                      ),
                                      child: DropdownButtonHideUnderline(
                                        child: DropdownButton(
                                          hint: Text(
                                            'Select Item',
                                            style: TextStyle(
                                              fontSize: 14,
                                              color:
                                                  Theme.of(context).hintColor,
                                            ),
                                          ),
                                          items: userValues
                                              .map((item) =>
                                                  DropdownMenuItem<String>(
                                                    value: item,
                                                    child: Text(
                                                      item,
                                                      style: const TextStyle(
                                                        fontSize: 14,
                                                      ),
                                                    ),
                                                  ))
                                              .toList(),
                                          value: model.userValue,
                                          onChanged: (String? newValue) {
                                            model.changeUserValue(newValue!);
                                          },
                                          // itemHeight: 40,
                                        ),
                                      )),
                                ),
                                horizontalSpaceMedium,
                                Expanded(
                                  child: Visibility(
                                    visible: model.userValue == "Donor",
                                    child: Container(
                                        height: 40,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          border: Border.all(
                                              color: Colors.grey,
                                              style: BorderStyle.solid,
                                              width: 0.80),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(
                                              'Select Item',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                            items: items
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            value: model.dropdownvalue,
                                            onChanged: (String? newValue) {
                                              model.changeDDValue(newValue!);
                                            },
                                            // itemHeight: 40,
                                          ),
                                        )),
                                  ),
                                ),
                                horizontalSpaceMedium,
                                Expanded(
                                  child: Visibility(
                                    visible: model.userValue == "Donor",
                                    child: Container(
                                        height: 40,
                                        padding: const EdgeInsets.all(10.0),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(30.0),
                                          border: Border.all(
                                              color: Colors.grey,
                                              style: BorderStyle.solid,
                                              width: 0.80),
                                        ),
                                        child: DropdownButtonHideUnderline(
                                          child: DropdownButton(
                                            hint: Text(
                                              'Select Item',
                                              style: TextStyle(
                                                fontSize: 14,
                                                color:
                                                    Theme.of(context).hintColor,
                                              ),
                                            ),
                                            items: availablityWise
                                                .map((item) =>
                                                    DropdownMenuItem<String>(
                                                      value: item,
                                                      child: Text(
                                                        item,
                                                        style: const TextStyle(
                                                          fontSize: 14,
                                                        ),
                                                      ),
                                                    ))
                                                .toList(),
                                            value: model.availableValue,
                                            onChanged: (String? newValue) {
                                              model.changeDDAvailableValue(
                                                  newValue!);
                                            },
                                            // itemHeight: 40,
                                          ),
                                        )),
                                  ),
                                ),
                                horizontalSpaceMedium,
                              ],
                            )
                          ],
                        ),
                        verticalSpaceMedium,
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.only(
                                left: 8.0, right: 8.0, bottom: 8.0),
                            child: model.userValue.toLowerCase() == "donor"
                                ? ListView.separated(
                                    itemCount: model.donorList.length,
                                    itemBuilder: (context, index) => Card(
                                      elevation: 3,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: NetworkImage(
                                            model.donorList[index].imageUrl,
                                          ),
                                        ),
                                        title: Text(
                                          "${model.donorList[index].userName} (${model.donorList[index].bloodGroup})",
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Email : ${model.donorList[index].email}"),
                                              Text(
                                                  "Age : ${model.donorList[index].age}"),
                                            ]),
                                        trailing: Icon(
                                          Icons.circle,
                                          color:
                                              model.donorList[index].isAvailable
                                                  ? Colors.green
                                                  : Colors.red,
                                          size: 16,
                                        ),
                                      ),
                                    ),
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(height: 10);
                                    },
                                  )
                                : ListView.separated(
                                    itemCount: model.patientList.length,
                                    itemBuilder: (context, index) => Card(
                                      elevation: 3,
                                      child: ListTile(
                                        leading: CircleAvatar(
                                          backgroundColor: Colors.transparent,
                                          backgroundImage: NetworkImage(
                                            model.donorList[index].imageUrl,
                                          ),
                                        ),
                                        title: Text(
                                          model.donorList[index].userName
                                              .toString(),
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  "Email : ${model.donorList[index].email}"),
                                              Text(
                                                  "Age : ${model.donorList[index].age}"),
                                            ]),
                                      ),
                                    ),
                                    separatorBuilder:
                                        (BuildContext context, int index) {
                                      return const SizedBox(height: 10);
                                    },
                                  ),
                          ),
                        ),
                      ],
                    ),
            ),
        viewModelBuilder: () => AdminViewModel()
        //  locator<HomeViewModel>(),
        );
  }
}
