import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

import 'donor_view_model.dart';

// ignore: must_be_immutable
class DonorView extends StatelessWidget {
  const DonorView({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return ViewModelBuilder<DonorViewModel>.reactive(
      builder: (context, model, child) => Scaffold(
        body: Container() ),
      viewModelBuilder: () => DonorViewModel(),
    );
  }
}
