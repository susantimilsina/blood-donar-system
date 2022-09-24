// ignore_for_file: file_names

import 'dart:convert';

class DonationModel {
  String center;
  String pints;
  String donatedDate;
  String userId;
  DonationModel(
      {required this.center,
      required this.pints,
      required this.donatedDate,
      required this.userId});

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'center': center});
    result.addAll({'pints': pints});
    result.addAll({'date': donatedDate});
    result.addAll({'userId': userId});
    return result;
  }

  factory DonationModel.fromMap(Map<String, dynamic> map) {
    return DonationModel(
        center: map['center'] ?? '',
        pints: map['pints'] ?? '',
        donatedDate: map['date'] ?? '',
        userId: map['userId'] ?? '');
  }

  String toJson() => json.encode(toMap());

  factory DonationModel.fromJson(String source) =>
      DonationModel.fromMap(json.decode(source));
}
