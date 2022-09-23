import 'package:blood_doner/ui/ViewProfile/viewprofile_viewmodel.dart';
import 'package:blood_doner/widgets/dumb/profileinfobar.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../ui/shared/ui_helper.dart';

// ignore: must_be_immutable
class ViewProfileView extends StatelessWidget {
  Map<String, dynamic> userMap;
  ViewProfileView(this.userMap, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return ViewModelBuilder<ViewProfileViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Padding(
          padding: const EdgeInsets.only(left: 32, top: 48, right: 24),
          child: Column(
              mainAxisSize: MainAxisSize.max,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.center,
                  child: CircleAvatar(
                    backgroundColor: Colors.transparent,
                    radius: 60,
                    backgroundImage:
                        NetworkImage(userMap['imageUrl'] as String),
                  ),
                ),
                verticalSpaceMedium,
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    (userMap['userName'] as String).toUpperCase(),
                    style: const TextStyle(fontSize: 20),
                  ),
                ),
                verticalSpaceLarge,
                ProfileInfoBar(data: 'Blood Group : ${userMap['bloodGroup']}'),
                verticalSpaceMedium,
                ProfileInfoBar(data: 'Age : ${userMap['age']}'),
                verticalSpaceMedium,
                ProfileInfoBar(data: 'Email : ${userMap['email']}'),
                verticalSpaceMedium,
                ProfileInfoBar(data: 'Role : ${userMap['role']}'),
                verticalSpaceMedium,
                (userMap["isAvailable"] ?? false)
                    ? ElevatedButton(
                        onPressed: () {
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
                                                        model.sendNotification(
                                                            userMap[
                                                                'bloodGroup']);
                                                        Navigator.pop(context);
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
                        child: const Text(
                          "Request for blood",
                        ))
                    : const Text(
                        "User is not available to donate blood",
                        style: TextStyle(color: Colors.red),
                      )
              ]),
        ),
      ),
      viewModelBuilder: () => ViewProfileViewModel(),
    );
  }
}
