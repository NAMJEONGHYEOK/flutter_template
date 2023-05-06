class UserInfo {
  //변수선언
  String userid;

  //생성자
  UserInfo({required this.userid});

  //개체선언
  factory UserInfo.fromJson(Map<String, dynamic> json) {
    return UserInfo(
      userid: json['uid'] as String,
    );
  }
}
