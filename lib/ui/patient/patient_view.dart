import 'package:blood_doner/ui/patient/patient_view_model.dart';
import 'package:blood_doner/ui/shared/ui_helper.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.router.dart';
import '../EditProfile/edit_profile_viewmodel.dart';

class PatientView extends StatelessWidget {
  PatientView({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();
  String selectedBloodgroup = "A+";

  @override
  Widget build(BuildContext context) {
    List<String> images = [
      "assets/image1.png",
      "assets/image2.jpeg",
      "assets/image3.png"
    ];
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
                                return StatefulBuilder(
                                    builder: (context, StateSetter setState) {
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
                                                        value:
                                                            selectedBloodgroup,
                                                        items: model.bgList,
                                                        onChanged: (data) {
                                                          setState(() {
                                                            selectedBloodgroup =
                                                                data.toString();
                                                          });

                                                          model.onChangedBloodgroup(
                                                              data.toString());
                                                        },
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
                      title: const Text('Contact Us'),
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
            body: Column(
              children: [
                CarouselSlider(
                  options: CarouselOptions(height: 400.0, autoPlay: true),
                  items: images.map((i) {
                    return Builder(
                      builder: (BuildContext context) {
                        return Container(
                            width: MediaQuery.of(context).size.width,
                            margin: EdgeInsets.symmetric(horizontal: 5.0),
                            child: Image.asset(
                              i,
                              fit: BoxFit.contain,
                            )
                            // Text(
                            //   'text $i',
                            //   style: TextStyle(fontSize: 16.0),
                            // ),
                            );
                      },
                    );
                  }).toList(),
                ),
                verticalSpaceLarge,
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 8.0),
                  child: Text(
                    "Blood Donor Hub is a licensed health care, blood donation centre and blood collection service based in Parramatta, New South Wales. We collect blood from various donors and help in minimizing the blood shortage. We directly supply the collected blood to hospitals, blood banks, biotechnology companies, and other research institutions.",
                    style: TextStyle(fontSize: 16, height: 1.5),
                  ),
                ),
              ],
            )),
        viewModelBuilder: () => PatientViewModel()
        //  locator<HomeViewModel>(),
        );
  }
}
