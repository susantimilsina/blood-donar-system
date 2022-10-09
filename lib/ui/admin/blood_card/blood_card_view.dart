import 'package:blood_doner/models/center_blood.dart';
import 'package:blood_doner/ui/shared/ui_helper.dart';
import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';
import '../../../widgets/dumb/blood_info_bar.dart';
import 'blood_card_view_model.dart';

// ignore: must_be_immutable
class BloodCardView extends StatelessWidget {
  List<Blood> userMap;
  BloodCardView(this.userMap, {Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<BloodCardViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container(
          padding: const EdgeInsets.only(left: 32, top: 48, right: 24),
          margin: const EdgeInsets.only(bottom: 20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Blood Bank Info",
                style: Theme.of(context).textTheme.headline5,
              ),
              verticalSpaceMedium,
              Row(
                children: [
                  Expanded(
                      child: Text(
                    "Blood Type",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.w400),
                  )),
                  Expanded(
                      child: Text(
                    "No. of Pints",
                    style: Theme.of(context)
                        .textTheme
                        .headline6
                        ?.copyWith(fontWeight: FontWeight.w400),
                  )),
                ],
              ),
              Column(
                  mainAxisSize: MainAxisSize.max,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: userMap
                      .map(
                        (e) => Container(
                          margin: const EdgeInsets.only(bottom: 20),
                          child: BloodInforBar(
                            data: e,
                          ),
                        ),
                      )
                      .toList()),
            ],
          ),
        ),
      ),
      viewModelBuilder: () => BloodCardViewModel(),
    );
  }
}
