// To parse this JSON data, do
//
//     final bloodCenter = bloodCenterFromJson(jsonString);

import 'dart:convert';

BloodCenter bloodCenterFromJson(String str) => BloodCenter.fromJson(json.decode(str));

String bloodCenterToJson(BloodCenter data) => json.encode(data.toJson());

class BloodCenter {
    BloodCenter({
        this.name,
        this.address,
        this.bloods,
    });

    String? name;
    String? address;
    List<Blood>? bloods;

    factory BloodCenter.fromJson(Map<String, dynamic> json) => BloodCenter(
        name: json["name"],
        address: json["address"],
        bloods: List<Blood>.from(json["bloods"].map((x) => Blood.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "name": name,
        "address": address,
        "bloods": List<dynamic>.from(bloods!.map((x) => x.toJson())),
    };
}

class Blood {
    Blood({
        this.bloodType,
        this.pints,
    });

    String? bloodType;
    int? pints;

    factory Blood.fromJson(Map<String, dynamic> json) => Blood(
        bloodType: json["bloodType"],
        pints: json["pints"],
    );

    Map<String, dynamic> toJson() => {
        "bloodType": bloodType,
        "pints": pints,
    };
}
