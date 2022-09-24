import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'package:uiblock/uiblock.dart';
import '../shared/ui_helper.dart';
import 'donate_form_view_model.dart';

class DonateFormView extends StatelessWidget {
  const DonateFormView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return ViewModelBuilder<DonateFormViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
          resizeToAvoidBottomInset: false,
          body: Padding(
            padding: const EdgeInsets.only(left: 32, top: 48, right: 24),
            child: SingleChildScrollView(
              child: Form(
                key: _formKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Column(
                        mainAxisSize: MainAxisSize.max,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              'Add a history',
                              style: TextStyle(fontSize: 30),
                            ),
                          ),
                          verticalSpaceMedium,
                          const Text(
                            'Blood Donation Center',
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextFormField(
                            controller: model.donationCenter,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              } else {
                                return "Cannot be empty";
                              }
                            },
                          ),
                          verticalSpaceMedium,
                          const Text(
                            'Blood(PINTS)',
                            style: TextStyle(color: Colors.grey),
                          ),
                          TextFormField(
                            controller: model.pints,
                            keyboardType: TextInputType.number,
                            validator: (value) {
                              if (value!.isNotEmpty) {
                                return null;
                              } else {
                                return "Cannot be empty";
                              }
                            },
                          ),
                          verticalSpaceMedium,
                          const Text(
                            'Blood Donation Date',
                            style: TextStyle(color: Colors.grey),
                          ),
                          Row(
                            children: [
                              Expanded(
                                  child: Text("${model.selectedDate.toLocal()}"
                                      .split(' ')[0])),
                              ElevatedButton(
                                clipBehavior: Clip.antiAlias,
                                style: ButtonStyle(
                                    backgroundColor: MaterialStateProperty.all(
                                        Colors.grey.shade100)),
                                onPressed: () async {
                                  final DateTime? picked = await showDatePicker(
                                      context: context,
                                      initialDate: model.selectedDate,
                                      firstDate: DateTime(2015, 8),
                                      lastDate: DateTime.now());
                                  if (picked != null &&
                                      picked != model.selectedDate) {
                                    model.changeSelectedDate(picked);
                                  }
                                },
                                child: const Text('Select date'),
                              ),
                            ],
                          ),
                          verticalSpaceMedium,
                          if (model.selectedDate
                                  .difference(DateTime.now())
                                  .inDays <
                              90)
                            const Text(
                              "If last donated date is less than 90 days. You are automatically made unavailable. You can always change it from edit profile",
                              style: TextStyle(color: Colors.red, fontSize: 16),
                            ),
                          verticalSpaceLarge,
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                onPressed: () {
                                  Navigator.pop(context);
                                },
                                child: const Text("CANCEL",
                                    style: TextStyle(
                                        fontSize: 14,
                                        letterSpacing: 2.2,
                                        color: Colors.black)),
                              ),
                              ElevatedButton(
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    UIBlock.block(context);
                                    model.createDonation(model.selectedDate
                                  .difference(DateTime.now())
                                  .inDays <
                              90);
                                    if (!model.isBusy) {
                                      UIBlock.unblock(context);
                                      Navigator.pop(context);
                                    }
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 35),
                                  elevation: 2,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(20)),
                                ),
                                child: const Text(
                                  "SAVE",
                                  style: TextStyle(
                                    fontSize: 14,
                                    letterSpacing: 2.2,
                                    color: Colors.black,
                                  ),
                                ),
                              )
                            ],
                          )
                        ]),
                  ],
                ),
              ),
            ),
          )),
      viewModelBuilder: () => DonateFormViewModel(),
    );
  }
}
