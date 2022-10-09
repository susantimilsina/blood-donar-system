import 'package:blood_doner/models/center_blood.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BloodInforBar extends StatelessWidget {
  Blood data;
  BloodInforBar({Key? key, required this.data}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
      child: Row(children: [
        Expanded(
          child: Text(
            data.bloodType.toString(),
            style: const TextStyle(fontSize: 16),
          ),
        ),
        Expanded(
          child: Text(
            data.pints.toString(),
            style: const TextStyle(fontSize: 16),
          ),
        ),
      ]),
    );
  }
}
