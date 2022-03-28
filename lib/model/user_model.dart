class UserModel {
  final String name;
  final String email;
  double? lat;
  double? long;

  UserModel({required this.name, required this.email, this.lat, this.long});

  factory UserModel.fromMap(Map<String, dynamic> json) {
    return UserModel(
      name: json['name'],
      email: json['email'],
      lat: json['lat'],
      long: json['long'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      "name": name,
      'email': email,
      'lat': lat,
      'long': long,
    };
  }
}
