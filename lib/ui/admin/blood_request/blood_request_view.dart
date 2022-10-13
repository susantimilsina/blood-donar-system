import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../shared/ui_helper.dart';
import 'blood_request_view_model.dart';

class BloodRequestView extends StatelessWidget {
  const BloodRequestView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return ViewModelBuilder<BloodRequestViewModel>.reactive(
        disposeViewModel:
            false, //so that we reuse the same viewmodel to maintain the state
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
              appBar: AppBar(
                title: const Text("Request History"),
              ),
              body: model.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : Padding(
                      padding: const EdgeInsets.only(
                          left: 8.0, right: 8.0, bottom: 8.0),
                      child: model.currentDataList.isEmpty
                          ? Center(
                              child: Text(
                                "No History found",
                                style: Theme.of(context).textTheme.headline5,
                              ),
                            )
                          : ListView.separated(
                              itemCount: model.currentDataList.length,
                              itemBuilder: (context, index) => Card(
                                elevation: 3,
                                child: ListTile(
                                  title: Text(
                                    'Name: ${model.currentDataList[index]["userName"]}',
                                    style: const TextStyle(
                                        fontWeight: FontWeight.bold),
                                  ),
                                  trailing: SizedBox(
                                    width: 90,
                                    child: Row(
                                      children: [
                                        Text(
                                          '${model.currentDataList[index]['blood_type']}',
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline5!
                                              .copyWith(color: Colors.red),
                                        ),
                                        IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              showDialog(
                                                  context: context,
                                                  builder:
                                                      (BuildContext context) {
                                                    return AlertDialog(
                                                      content: SizedBox(
                                                        width: 500,
                                                        child: Form(
                                                          key: _formKey,
                                                          child: Column(
                                                            mainAxisSize:
                                                                MainAxisSize
                                                                    .min,
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: <Widget>[
                                                              Text(
                                                                "Send Notification",
                                                                style: Theme.of(
                                                                        context)
                                                                    .textTheme
                                                                    .headline5!
                                                                    .copyWith(
                                                                        fontWeight:
                                                                            FontWeight.bold),
                                                              ),
                                                              verticalSpaceMedium,
                                                              const Text(
                                                                'Title',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .black,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              TextField(
                                                                controller: model
                                                                    .titleCon,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                // controller: model.emailController,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  hintText:
                                                                      'Title',
                                                                ),
                                                              ),
                                                              verticalSpaceMedium,
                                                              Text(
                                                                'Description',
                                                                style: TextStyle(
                                                                    color: Colors
                                                                        .grey
                                                                        .shade700,
                                                                    fontSize:
                                                                        18),
                                                              ),
                                                              TextField(
                                                                controller: model
                                                                    .descriptionCon,
                                                                keyboardType:
                                                                    TextInputType
                                                                        .text,
                                                                // controller: model.emailController,
                                                                decoration:
                                                                    const InputDecoration(
                                                                  hintText:
                                                                      'Description',
                                                                ),
                                                              ),
                                                              Row(
                                                                children: [
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        ElevatedButton(
                                                                      // ignore: sort_child_properties_last
                                                                      child: const Text(
                                                                          "Cancel"),
                                                                      style: ButtonStyle(
                                                                          backgroundColor: MaterialStateProperty.all(Colors
                                                                              .grey
                                                                              .shade100)),
                                                                      onPressed:
                                                                          () {
                                                                        model
                                                                            .titleCon
                                                                            .text = "";
                                                                        model
                                                                            .descriptionCon
                                                                            .text = "";

                                                                        Navigator.pop(
                                                                            context);
                                                                      },
                                                                    ),
                                                                  ),
                                                                  Padding(
                                                                    padding:
                                                                        const EdgeInsets.all(
                                                                            8.0),
                                                                    child:
                                                                        ElevatedButton(
                                                                      style: ButtonStyle(
                                                                          backgroundColor:
                                                                              MaterialStateProperty.all(Colors.green)),
                                                                      child: const Text(
                                                                          "Send"),
                                                                      onPressed:
                                                                          () {
                                                                        if (_formKey
                                                                            .currentState!
                                                                            .validate()) {
                                                                          {
                                                                            Navigator.pop(context);
                                                                            model.addNotification(model.currentDataList[index]['userId'].toString());
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
                                                      ),
                                                    );
                                                  });
                                            },
                                            icon:
                                                const Icon(Icons.notifications))
                                      ],
                                    ),
                                  ),
                                  subtitle: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Date: ${model.currentDataList[index]['date']}',
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        'Purpose: ${model.currentDataList[index]['purpose']}',
                                      ),
                                    ],
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
        viewModelBuilder: () => BloodRequestViewModel()
        //  locator<HomeViewModel>(),
        );
  }
}
