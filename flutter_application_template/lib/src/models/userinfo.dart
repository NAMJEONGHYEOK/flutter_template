// class UserInfo {
//   //변수선언
//   String userid;

//   //생성자
//   UserInfo({required this.userid});

//   //개체선언
//   factory UserInfo.fromJson(Map<String, dynamic> json) {
//     return UserInfo(
//       userid: json['uid'] as String,
//     );
//   }
// }
class User {
  final String id;
  final String name;
  final String email;
  final String phone_num;

  User(
      {required this.id,
      required this.name,
      required this.email,
      required this.phone_num});

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
