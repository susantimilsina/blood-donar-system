import 'package:blood_doner/ui/patient/patient_view_model.dart';
import 'package:blood_doner/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.router.dart';
import '../EditProfile/edit_profile_viewmodel.dart';

class PatientView extends StatelessWidget {
  const PatientView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return ViewModelBuilder<PatientViewModel>.reactive(
        disposeViewModel:
            false, //so that we reuse the same viewmodel to maintain the state
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
            appBar: AppBar(
              title: const Text("Patient Home Page"),
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
                                                      color:
                                                          Colors.grey.shade700,
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
                                                      const EdgeInsets.all(8.0),
                                                  child: ElevatedButton(
                                                    child: Text("Cancel"),
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors.grey
                                                                    .shade100)),
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                    },
                                                  ),
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(8.0),
                                                  child: ElevatedButton(
                                                    style: ButtonStyle(
                                                        backgroundColor:
                                                            MaterialStateProperty
                                                                .all(Colors
                                                                    .green)),
                                                    child: const Text("Submit"),
                                                    onPressed: () {
                                                      if (_formKey.currentState!
                                                          .validate()) {
                                                        {
                                                          model
                                                              .createDonation()
                                                              .then((value) {
                                                            Navigator.pop(
                                                                context);
                                                          });
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
                        Icons.history,
                      ),
                      title: const Text('Request History'),
                      onTap: () {
                        Navigator.pop(context);
                        model.changeNavToRoute(Routes.patientHistoryView);
                      },
                    ),
                    ListTile(
                      leading: const Icon(
                        Icons.edit,
                      ),
                      title: const Text('Edit Profile'),
                      onTap: () {
                        Navigator.pop(context);
                        model.changeNavToRoute(Routes.editProfileView);
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
            body: const Center(
              child: Text("Description . Just Prepare them as u wish"),
            )),
        viewModelBuilder: () => PatientViewModel()
        //  locator<HomeViewModel>(),
        );
  }
}
