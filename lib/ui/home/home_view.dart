import 'package:blood_doner/ui/ViewProfile/viewprofile_view.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../app/app.router.dart';
import 'home_viewmodel.dart';
import 'package:animations/animations.dart';

class HomeView extends StatelessWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var items = ['All', 'A+', 'A-', 'B+', 'B-', 'AB+', 'AB-', 'O+', 'O-'];
    return ViewModelBuilder<HomeViewModel>.reactive(
        disposeViewModel:
            false, //so that we reuse the same viewmodel to maintain the state
        initialiseSpecialViewModelsOnce: true,
        builder: (context, model, child) => Scaffold(
              body: model.isBusy
                  ? const Center(child: CircularProgressIndicator())
                  : NestedScrollView(
                      floatHeaderSlivers: false,
                      headerSliverBuilder: (_, bool innerBoxIsScrolled) => [
                        SliverAppBar(
                          actions: [
                            PopupMenuButton(
                                itemBuilder: (_) => [
                                      PopupMenuItem(
                                        onTap: () {
                                          model.changeNav();
                                        },
                                        child: const Text('Edit Profile'),
                                      ),
                                      PopupMenuItem(
                                        onTap: model.performLogout,
                                        child: const Text('Logout'),
                                      ),
                                    ])
                          ],
                          stretch: true,
                          expandedHeight: 30,
                          floating: true,
                          title: const Text('Blood Bank'),
                        )
                      ],
                      body: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          Row(
                            children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 8.0),
                                child: Text(
                                  "Choose Blood Group",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                              ),
                              Container(
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
                            ],
                          ),
                          Expanded(
                            child: RefreshIndicator(
                              onRefresh: model.futureToRun,
                              // showChildOpacityTransition: false,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 8.0, right: 8.0, bottom: 8.0),
                                child: ListView.separated(
                                  itemCount: model.displayList.length,
                                  itemBuilder: (context, index) =>
                                      OpenContainer(
                                    transitionDuration:
                                        const Duration(seconds: 1),
                                    openBuilder: (context, action) =>
                                        ViewProfileView(
                                            Map<String, String>.from(
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
                                            model.displayList[index]
                                                ['imageUrl'],
                                          ),
                                        ),
                                        title: Text(
                                          '${model.displayList[index]['userName']} (${model.displayList[index]['role']})',
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold),
                                        ),
                                        subtitle: Text(
                                            'Blood group : ${model.displayList[index]['bloodGroup']}'),
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
            ),
        viewModelBuilder: () => HomeViewModel()
        //  locator<HomeViewModel>(),
        );
  }
}
