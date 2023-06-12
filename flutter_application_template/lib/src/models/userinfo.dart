class User {
  final String? id;
  final String? name;
  final String? email;
  final String? phone_num;

  User(
      {required this.id,
      required this.name,
      required this.email,
      this.phone_num});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phone_num: json['phone_num'],
    );
  }

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'email': email,
        'phone_num': phone_num,
      };
}
