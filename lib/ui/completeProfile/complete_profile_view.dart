import 'dart:io';
import 'package:blood_doner/ui/completeProfile/complete_profile_viewmodel.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../shared/ui_helper.dart';

class CompleteProfileView extends StatelessWidget {
  const CompleteProfileView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<CompleteProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.only(left: 40, top: 24, right: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                verticalSpaceMedium,
                model.pickedImage == null
                    ? CircleAvatar(
                        radius: 50,
                        backgroundColor: Colors.grey.shade100,
                        child: const Icon(Icons.person),
                      )
                    : CircleAvatar(
                        radius: 50,
                        backgroundImage:
                            FileImage(File(model.pickedImage!.path)),
                      ),
                verticalSpaceTiny,
                GestureDetector(
                  onTap: model.selectImage,
                  child: const Text(
                    'Upload Profile Picture',
                    style: TextStyle(color: Colors.green),
                  ),
                ),
                verticalSpaceMedium,
                TextField(
                  keyboardType: TextInputType.name,
                  controller: model.nameController,
                  decoration: const InputDecoration(
                      hintText: 'Your name',
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(20)))),
                ),
                verticalSpaceSmall,
                TextField(
                  keyboardType: TextInputType.number,
                  controller: model.ageController,
                  decoration: const InputDecoration(
                    hintText: 'Your age',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                verticalSpaceSmall,
                TextField(
                  keyboardType: TextInputType.number,
                  controller: model.numberController,
                  decoration: const InputDecoration(
                    hintText: 'Your Number',
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(20))),
                  ),
                ),
                verticalSpaceTiny,
                Row(
                  children: [
                    Text(
                      'Blood group',
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 16),
                    ),
                    horizontalSpaceMedium,
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: 0.45),
                      child: DropdownButton(
                        value: model.selectedBloodgroup,
                        items: model.bgList,
                        onChanged: model.onChangedBloodgroup,
                        isExpanded: true,
                      ),
                    ),
                  ],
                ),
                Row(
                  children: [
                    Text(
                      'Purpose',
                      style:
                          TextStyle(color: Colors.grey.shade700, fontSize: 16),
                    ),
                    horizontalSpaceLarge,
                    SizedBox(
                      width: screenWidthPercentage(context, percentage: 0.45),
                      child: DropdownButton(
                        value: model.selectedRole,
                        items: model.roleList,
                        onChanged: model.onChangedPurpose,
                        isExpanded: true,
                      ),
                    ),
                  ],
                ),
                verticalSpaceSmall,
                model.selectedRole == "Donor"
                    ? Row(
                        children: [
                          Text(
                            'Available for donation',
                            style: TextStyle(
                                color: Colors.grey.shade700, fontSize: 16),
                          ),
                          horizontalSpaceLarge,
                          CupertinoSwitch(
                              value: model.isAvailable,
                              onChanged: (value) {
                                model.toggleAvailable();
                              }),
                        ],
                      )
                    : Container(),
                CheckboxListTile(
                  contentPadding: EdgeInsets.zero,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: RichText(
                    text: TextSpan(
                      text: 'I agree ',
                      style: Theme.of(context).textTheme.subtitle1,
                      children: [
                        TextSpan(
                          recognizer: TapGestureRecognizer()
                            ..onTap = () {
                              showDataAlert(context);
                            },
                          text: 'terms and conditions',
                          style: const TextStyle(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  value: false,
                  onChanged: (val) {
                    model.toggleAccepted();
                  },
                ),
                verticalSpaceLarge,
                GestureDetector(
                  onTap: model.createUserinDb,
                  child: Container(
                    width: screenWidthPercentage(context, percentage: 0.65),
                    height: 54,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(25),
                      gradient: const LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [Color(0xffffd200), Color(0xfff7971e)]),
                      boxShadow: const [
                        BoxShadow(
                          color: Color(0x3f000000),
                          blurRadius: 4,
                          offset: Offset(0, 4),
                        ),
                      ],
                    ),
                    child: Center(
                        child: model.isBusy
                            ? const CircularProgressIndicator(
                                strokeWidth: 2,
                                color: Colors.deepOrangeAccent,
                              )
                            : Text(
                                'Upload Details',
                                style: Theme.of(context).textTheme.bodyText1,
                              )),
                  ),
                ),
              ],
            ),
          )),
      viewModelBuilder: () => CompleteProfileViewModel(),
    );
  }

  showDataAlert(context) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(
                  20.0,
                ),
              ),
            ),
            contentPadding: const EdgeInsets.only(
              top: 10.0,
            ),
            title: const Text(
              "Terms and Conditions",
              style: TextStyle(fontSize: 24.0),
            ),
            content: SizedBox(
              height: 400,
              child: SingleChildScrollView(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "1. General User Terms",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "1.1 Access, use and upload content to the Blood Donor Hub Mobile Application. \n" +
                            "1.2 View, manage appointments and interact with any content, information, communications, text or other material provided by Blood Donor Hub (Blood Donor Hub Content) or any User Content.\n" +
                            "1.3 Blood may from time-to-time review and update these Terms including to take account of new laws, regulations, products or technology.\n" +
                            "1.4 All intellectual property rights, including copyright, in the Blood Donor Hub Mobile App and its content are owned or licenced by Blood Donor Hub or any of its related entities.\n" +
                            "1.5 If you have a complaint regarding any User Content, Blood Donor Hub’s sole obligation will be to review any written complaint notified to it and, if it sees fit, in its sole discretion, to modify or remove the particular app’s content or user content.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "2. App Terms",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "2.1 You acknowledge and agree that by using our Donor Mobile App, while you can download the Donor Mobile App in the Google Play Store Market or Apple App Store free of charge, you may incur charges from your wireless or mobile carrier in accordance with your agreements with them, and that any such charges will be your sole responsibility.  \n" +
                            "2.2 Lifeblood does not promise you that you will have uninterrupted or error-free access to and use of the Blood Donor Hub Mobile App or User Content.\n" +
                            "2.3 These terms are an End User Licence Agreement (or EULA) for the purposes of the terms of any store where you have purchased the App.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "3. Disclaimer",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "3.1 Content on materials in this system are designed for the Australian practice and is relevant to Australian settings unless otherwise specified.\n" +
                            "3.2 Reports, research and publication. Your registration to this system is voluntary. \n" +
                            "3.3 You agree that the information that you provide may be subject to research and statistical reporting.",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.all(8.0),
                      child: Text(
                        "4. Termination of use ",
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text(
                        "4.1 I have understood that Blood donation is a totally voluntary act and no inducement or remuneration has been offered. Donation of Blood/components is a medical procedure and that by donating voluntarily. I accept the risks associated with this procedure. My blood will be tested for Hepatitis B/C, Malaria parasite, HIV/AIDS and venereal diseases in addition to any other screening tests required to ensure blood safety. I prohibit any information provided by me or about my donation to be disclosed to any individual or government agency without any prior permission.\n" +
                            "4.2 A violation of any of the above terms by you may result in immediate suspension or limit access to the system. \n",
                        style: TextStyle(fontSize: 12),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        });
  }
}
