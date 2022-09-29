import 'package:blood_doner/ui/ViewProfile/viewprofile_view.dart';
import 'package:blood_doner/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../EditProfile/edit_profile_viewmodel.dart';
import 'home_viewmodel.dart';
import 'package:animations/animations.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    var items = ['All', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
    var availablityWise = ['All', 'Available', 'Unavaiable'];
    return ViewModelBuilder<HomeViewModel>.reactive(
        disposeViewModel:
            false, //so that we reuse the same viewmodel to maintain the state
        initialiseSpecialViewModelsOnce: true,
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
                      if (insidemodel.getRole.toLowerCase().startsWith("p"))
                        ListTile(
                          leading: const Icon(
                            Icons.bloodtype_sharp,
                          ),
                          title: const Text('Ask for blood'),
                          onTap: () {
                            Navigator.pop(context);
                            showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    content: Stack(
                                      children: <Widget>[
                                        Form(
                                          key: _formKey,
                                          child: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: <Widget>[
                                              const Text(
                                                'Purpose you need blood',
                                                style: TextStyle(
                                                    color: Colors.black,
                                                    fontSize: 16),
                                              ),
                                              Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        horizontal: 8.0),
                                                child: TextField(
                                                  controller:
                                                      model.purposeController,
                                                  keyboardType:
                                                      TextInputType.text,
                                                  // controller: model.emailController,
                                                  decoration:
                                                      const InputDecoration(
                                                    hintText: 'Purpose',
                                                  ),
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  Text(
                                                    'Blood group',
                                                    style: TextStyle(
                                                        color: Colors
                                                            .grey.shade700,
                                                        fontSize: 16),
                                                  ),
                                                  horizontalSpaceMedium,
                                                  Flexible(
                                                    child: SizedBox(
                                                      width:
                                                          screenWidthPercentage(
                                                              context,
                                                              percentage: 0.45),
                                                      child: DropdownButton(
                                                        value: model
                                                            .selectedBloodgroup,
                                                        items: model.bgList,
                                                        onChanged: model
                                                            .onChangedBloodgroup,
                                                        isExpanded: true,
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ElevatedButton(
                                                      child: Text("Cancel"),
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .grey
                                                                      .shade100)),
                                                      onPressed: () {
                                                        Navigator.pop(context);
                                                      },
                                                    ),
                                                  ),
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            8.0),
                                                    child: ElevatedButton(
                                                      style: ButtonStyle(
                                                          backgroundColor:
                                                              MaterialStateProperty
                                                                  .all(Colors
                                                                      .green)),
                                                      child:
                                                          const Text("Submit"),
                                                      onPressed: () {
                                                        if (_formKey
                                                            .currentState!
                                                            .validate()) {
                                                          {
                                                            model
                                                                .sendNotification();
                                                            Navigator.pop(
                                                                context);
                                                          }
                                                        }
                                                      },
                                                    ),
                                                  ),
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                });
                          },
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
                                      "Blood Group",
                                      style:
                                          Theme.of(context).textTheme.headline6,
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Text(
                                      "Availability",
                                      style:
                                          Theme.of(context).textTheme.headline6,
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
                                horizontalSpaceMedium,
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
                                horizontalSpaceMedium,
                              ],
                            )
                          ],
                        ),
                        verticalSpaceMedium,
                        Expanded(
                          child: RefreshIndicator(
                            onRefresh: model.futureToRun,
                            // showChildOpacityTransition: false,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 8.0, right: 8.0, bottom: 8.0),
                              child: ListView.separated(
                                itemCount: model.displayList.length,
                                itemBuilder: (context, index) => OpenContainer(
                                  transitionDuration:
                                      const Duration(seconds: 1),
                                  openBuilder: (context, action) =>
                                      ViewProfileView(Map<String, dynamic>.from(
                                          model.displayList[index])),
                                  closedBuilder:
                                      (context, VoidCallback openContainer) =>
                                          Card(
                                    elevation: 3,
                                    child: ListTile(
                                      onTap: openContainer,
                                      leading: CircleAvatar(
                                        backgroundColor: Colors.transparent,
                                        backgroundImage: NetworkImage(
                                          model.displayList[index]['imageUrl'],
                                        ),
                                      ),
                                      title: Text(
                                        '${model.displayList[index]['userName']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      trailing: Icon(
                                        Icons.circle,
                                        color: model.displayList[index]
                                                    ['isAvailable'] ??
                                                false
                                            ? Colors.green
                                            : Colors.red,
                                        size: 16,
                                      ),
                                      subtitle: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                              'Blood group : ${model.displayList[index]['bloodGroup']}'),
                                          Text(
                                              'Distance(In Km): ${model.calculateDistance((model.displayList[index]['latitude']), model.displayList[index]['longitude'])}'),
                                        ],
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
                        ),
                      ],
                    ),
            ),
        viewModelBuilder: () => HomeViewModel()
        //  locator<HomeViewModel>(),
        );
  }

}
