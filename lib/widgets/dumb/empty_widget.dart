import 'package:flutter/material.dart';

// ignore: must_be_immutable
class EmptyWidget extends StatelessWidget {
  String data;
  EmptyWidget({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/nodata.jpg"),
          Text(
            data,
            style: Theme.of(context).textTheme.headline4,
          )
        ]);
  }
}
