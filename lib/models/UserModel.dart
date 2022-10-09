import 'dart:convert';

class UserModel {
  String userName;
  String email;
  String bloodGroup;
  String age;
  String number;
  String role;
  String imageUrl;
  String imageFileName;
  String latitude;
  String longitude;
  bool isAvailable;
  UserModel(
      {required this.userName,
      required this.email,
      required this.bloodGroup,
      required this.age,
      required this.number,
      required this.role,
      required this.imageUrl,
      required this.imageFileName,
      required this.latitude,
      required this.longitude,
      required this.isAvailable});

  UserModel copyWith(
      {String? userName,
      String? email,
      String? bloodGroup,
      String? age,
      String? role,
      String? imageUrl,
      String? imageFileName,
      String? latitude,
      String? longitude,
      bool? isAvailable}) {
    return UserModel(
        userName: userName ?? this.userName,
        email: email ?? this.email,
        bloodGroup: bloodGroup ?? this.bloodGroup,
        age: age ?? this.age,
        number: number,
        role: role ?? this.role,
        imageUrl: imageUrl ?? this.imageUrl,
        imageFileName: imageFileName ?? this.imageFileName,
        latitude: latitude ?? this.latitude,
        longitude: longitude ?? this.longitude,
        isAvailable: isAvailable ?? this.isAvailable);
  }

  Map<String, dynamic> toMap() {
    final result = <String, dynamic>{};

    result.addAll({'userName': userName});
    result.addAll({'email': email});
    result.addAll({'bloodGroup': bloodGroup});
    result.addAll({'age': age});
    result.addAll({'number': number});
    result.addAll({'role': role});
    result.addAll({'latitude': latitude});
    result.addAll({'longitude': longitude});
    result.addAll({'imageUrl': imageUrl});
    result.addAll({'imageFileName': imageFileName});
    result.addAll({'isAvailable': isAvailable});

    return result;
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        userName: map['userName'] ?? '',
        email: map['email'] ?? '',
        bloodGroup: map['bloodGroup'] ?? '',
        age: map['age'] ?? '',
        number: map['number'] ?? '',
        role: map['role'] ?? '',
        imageUrl: map['imageUrl'] ?? '',
        imageFileName: map['imageFileName'] ?? '',
        latitude: map['latitude'] ?? '0.0',
        longitude: map['longitude'] ?? '0.0',
        isAvailable: map['isAvailable'] ?? true);
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source));

  @override
  String toString() {
    return 'UserModel(userName: $userName, email: $email, bloodGroup: $bloodGroup, age: $age, role: $role, imageUrl: $imageUrl, imageFileName: $imageFileName, isAvailable : $isAvailable)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is UserModel &&
        other.userName == userName &&
        other.email == email &&
        other.bloodGroup == bloodGroup &&
        other.age == age &&
        other.number == number &&
        other.role == role &&
        other.imageUrl == imageUrl &&
        other.latitude == latitude &&
        other.longitude == longitude &&
        other.imageFileName == imageFileName &&
        other.isAvailable == isAvailable;
  }

  @override
  int get hashCode {
    return userName.hashCode ^
        email.hashCode ^
        bloodGroup.hashCode ^
        age.hashCode ^
        number.hashCode ^
        role.hashCode ^
        imageUrl.hashCode ^
        imageFileName.hashCode ^
        latitude.hashCode ^
        longitude.hashCode ^
        isAvailable.hashCode;
  }
}
