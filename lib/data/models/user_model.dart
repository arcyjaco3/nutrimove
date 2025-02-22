class UserModel {
  final String? id;
  final String email;
  final String name;
  final String? password;
  final int age;
  final String gender;
  final int height;
  final int weight;

  const UserModel({
    this.id,
    required this.email,
    required this.name,
    this.password,
    required this.age,
    required this.gender,
    required this.height,
    required this.weight,
  });

  Map<String, dynamic> toJson() {
    return {
      'email': email,
      'name': name,
      'password': password,
      'age': age,
      'gender': gender,
      'height': height,
      'weight': weight,
    };
  }
}