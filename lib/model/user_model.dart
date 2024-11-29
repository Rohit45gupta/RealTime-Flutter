class UserModel {
  late final String userId;
  late final String name;
  late final String age;
  late final String gender;

  UserModel(
      {required this.userId,
      required this.name,
      required this.age,
      required this.gender});

  Map<String, dynamic> toMap() {
    return {
      'userId': userId,
      'name': name,
      'age': age,
      'gender': gender
    };
  }

  factory UserModel.fromjson(Map<String, dynamic> json) {
    return UserModel(
        userId: json['userId'] ?? '',
        name: json['name'] ?? '',
        age: json['age'] ?? '',
        gender: json['gender'] ?? '');
  }
}
