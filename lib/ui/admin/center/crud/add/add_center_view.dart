import 'package:blood_doner/ui/admin/center/crud/add/add_center_view_model.dart';
import 'package:blood_doner/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class AddCenterView extends StatefulWidget {
  AddCenterView({Key? key}) : super(key: key);

  @override
  State<AddCenterView> createState() => _AddCenterViewState();
}

class _AddCenterViewState extends State<AddCenterView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Blood Center"),
      ),
      body: ViewModelBuilder<AddCenterViewModel>.reactive(
        builder: (context, model, child) => model.isBusy
            ? const Center(child: CircularProgressIndicator())
            : SingleChildScrollView(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8.0, vertical: 20),
                  child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        TextField(
                          keyboardType: TextInputType.name,
                          controller: model.nameController,
                          decoration: const InputDecoration(
                              hintText: 'Name',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                        verticalSpaceRegular,
                        TextField(
                          keyboardType: TextInputType.name,
                          controller: model.addressController,
                          decoration: const InputDecoration(
                              hintText: 'Address',
                              border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(20)))),
                        ),
                        verticalSpaceMedium,
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            "Available Blood",
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ),
                        ),
                        verticalSpaceSmall,
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 8.0),
                          child: Column(
                            children: [
                              Row(
                                children: const [
                                  Expanded(
                                      flex: 1,
                                      child: Text(
                                        "Blood+",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      )),
                                  Expanded(
                                      flex: 5,
                                      child: Text(
                                        "Available Pints",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.w500),
                                      ))
                                ],
                              ),
                              verticalSpaceSmall,
                              Row(
                                children: [
                                  const Expanded(flex: 1, child: Text("O+")),
                                  Expanded(
                                    flex: 5,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: model.opController,
                                      decoration: const InputDecoration(
                                          hintText: 'No. of Pints',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)))),
                                    ),
                                  )
                                ],
                              ),
                              verticalSpaceSmall,
                              Row(
                                children: [
                                  const Expanded(flex: 1, child: Text("O-")),
                                  Expanded(
                                    flex: 5,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: model.onController,
                                      decoration: const InputDecoration(
                                          hintText: 'No. of Pints',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)))),
                                    ),
                                  )
                                ],
                              ),
                              verticalSpaceSmall,
                              Row(
                                children: [
                                  const Expanded(flex: 1, child: Text("AB+")),
                                  Expanded(
                                    flex: 5,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: model.abpController,
                                      decoration: const InputDecoration(
                                          hintText: 'No. of Pints',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)))),
                                    ),
                                  )
                                ],
                              ),
                              verticalSpaceSmall,
                              Row(
                                children: [
                                  const Expanded(flex: 1, child: Text("AB-")),
                                  Expanded(
                                    flex: 5,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: model.abnController,
                                      decoration: const InputDecoration(
                                          hintText: 'No. of Pints',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)))),
                                    ),
                                  )
                                ],
                              ),
                              verticalSpaceSmall,
                              Row(
                                children: [
                                  const Expanded(flex: 1, child: Text("A+")),
                                  Expanded(
                                    flex: 5,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: model.apController,
                                      decoration: const InputDecoration(
                                          hintText: 'No. of Pints',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)))),
                                    ),
                                  )
                                ],
                              ),
                              verticalSpaceSmall,
                              Row(
                                children: [
                                  const Expanded(flex: 1, child: Text("A-")),
                                  Expanded(
                                    flex: 5,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: model.anController,
                                      decoration: const InputDecoration(
                                          hintText: 'No. of Pints',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)))),
                                    ),
                                  )
                                ],
                              ),
                              verticalSpaceSmall,
                              Row(
                                children: [
                                  const Expanded(flex: 1, child: Text("B+")),
                                  Expanded(
                                    flex: 5,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: model.bpController,
                                      decoration: const InputDecoration(
                                          hintText: 'No. of Pints',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)))),
                                    ),
                                  )
                                ],
                              ),
                              verticalSpaceSmall,
                              Row(
                                children: [
                                  const Expanded(flex: 1, child: Text("B-")),
                                  Expanded(
                                    flex: 5,
                                    child: TextField(
                                      keyboardType: TextInputType.number,
                                      controller: model.bnController,
                                      decoration: const InputDecoration(
                                          hintText: 'No. of Pints',
                                          border: OutlineInputBorder(
                                              borderRadius: BorderRadius.all(
                                                  Radius.circular(20)))),
                                    ),
                                  )
                                ],
                              ),
                              verticalSpaceMedium,
                              GestureDetector(
                                onTap: model.addCenter,
                                child: Container(
                                  width: screenWidthPercentage(context,
                                      percentage: 0.65),
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
                                              'Add',
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .bodyText1,
                                            )),
                                ),
                              ),
                            ],
                          ),
                        )
                      ]),
                ),
              ),
        viewModelBuilder: () => AddCenterViewModel(),
      ),
    );
  }
}
