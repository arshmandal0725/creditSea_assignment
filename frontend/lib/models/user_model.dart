class UserModel {
  final String id;
  final String phone;
  final String name;
  final String? dob;
  final String? gender;
  final String? pan;
  final String? email;

  UserModel({
    required this.id,
    required this.phone,
    required this.name,
    this.dob,
    this.gender,
    this.pan,
    this.email,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['_id'] ?? '',
      phone: json['phone'] ?? '',
      name: json['name'] ?? '',
      dob: json['dob'],
      gender: json['gender'],
      pan: json['pan'],
      email: json['email'],
    );
  }
}
