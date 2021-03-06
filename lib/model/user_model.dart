import 'package:my_circle/model/group_model.dart';

class UserModel {
  final String id;
  final String name;
  final String email;
  double? lat;
  double? long;
  String? role;

  UserModel({required this.id,required this.name, required this.email, this.lat, this.long,this.role,});

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      lat: json['lat'] == null?null:json['lat'],
      long: json['long'] == null?null:json['long'],
      role: json['role'] == null?null:json['role'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id':id,
      "name": name,
      'email': email,
      'lat': lat,
      'long': long,
      'role': role,
    };
  }
}
