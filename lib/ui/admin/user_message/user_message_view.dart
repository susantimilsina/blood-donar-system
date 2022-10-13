import 'package:blood_doner/app/app.router.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import 'user_message_view_model.dart';

class UserMessageView extends StatelessWidget {
  const UserMessageView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Users"),
      ),
      body: ViewModelBuilder<UserMessageViewModel>.reactive(
          disposeViewModel: true,
          builder: (context, model, child) => Padding(
                padding:
                    const EdgeInsets.only(left: 8.0, right: 8.0, bottom: 8.0),
                child: ListView.builder(
                  itemCount: model.displayList.length,
                  itemBuilder: (context, index) => Card(
                    elevation: 0,
                    child: ListTile(
                      onTap: () {
                        
                        model.changeNavToRoute(
                            Routes.messageViewScreen,
                            model.displayList[index]["id"].toString(),
                            model.displayList[index]["username"].toString());
                      },
                      title: Text(
                        model.displayList[index]["username"].toString(),
                        style: const TextStyle(fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),
              ),
          viewModelBuilder: () => UserMessageViewModel()),
    );
  }
}
