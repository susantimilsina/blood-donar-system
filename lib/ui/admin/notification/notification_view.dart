import 'package:blood_doner/ui/admin/notification/notification_view_model.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import '../../shared/ui_helper.dart';

class NotificationViewScreen extends StatelessWidget {
  const NotificationViewScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

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
    var availablityWise = ['All', 'Available', 'Unavaiable'];
    return Scaffold(
      appBar: AppBar(
        title: const Text("Send Notification"),
      ),
      body: ViewModelBuilder<NotificationViewModel>.reactive(
          disposeViewModel:
              false, //so that we reuse the same viewmodel to maintain the state
          viewModelBuilder: () => NotificationViewModel(),
          initialiseSpecialViewModelsOnce: true,
          builder: (context, model, child) => SingleChildScrollView(
                  child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      verticalSpaceLarge,
                      Row(
                        children: [
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Blood Group",
                                style: Theme.of(context).textTheme.headline6,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Availability",
                                style: Theme.of(context).textTheme.headline6,
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
                                  borderRadius: BorderRadius.circular(30.0),
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
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: items
                                        .map((item) => DropdownMenuItem<String>(
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
                                  borderRadius: BorderRadius.circular(30.0),
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
                                        color: Theme.of(context).hintColor,
                                      ),
                                    ),
                                    items: availablityWise
                                        .map((item) => DropdownMenuItem<String>(
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
                                      model.changeDDAvailableValue(newValue!);
                                    },
                                    // itemHeight: 40,
                                  ),
                                )),
                          ),
                          horizontalSpaceMedium,
                        ],
                      ),
                      verticalSpaceMedium,
                      Text(
                        "Notification Title",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      verticalSpaceSmall,
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        controller: model.titleController,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Title is empty";
                          }
                          return null;
                        },
                        decoration: const InputDecoration(
                            hintText: 'Write a title',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      ),
                      verticalSpaceMedium,
                      Text(
                        "Notification Description",
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      verticalSpaceSmall,
                      TextFormField(
                        keyboardType: TextInputType.emailAddress,
                        maxLines: 5,
                        validator: (text) {
                          if (text!.isEmpty) {
                            return "Decription is empty";
                          }
                          return null;
                        },
                        controller: model.descriptionController,
                        decoration: const InputDecoration(
                            hintText: 'Write a description',
                            border: OutlineInputBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20)))),
                      ),
                      verticalSpaceMedium,
                      GestureDetector(
                        onTap: () {
                          if (formKey.currentState!.validate()) {
                            model.addNotification();
                          }
                        },
                        child: Center(
                          child: Container(
                            width: screenWidthPercentage(context,
                                percentage: 0.45),
                            height: 54,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              gradient: const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color(0xffffd200),
                                    Color(0xfff7971e)
                                  ]),
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
                                        'Send Notification',
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                      )),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ))),
    );
  }
}
