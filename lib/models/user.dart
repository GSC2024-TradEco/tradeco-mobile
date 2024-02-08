class User {
  final int id;
  final String uid;
  final String displayName;
  final String email;
  final String? password;

  User(
      {required this.id,
      required this.uid,
      required this.displayName,
      required this.email,
      this.password});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        uid: json['uid'],
        displayName: json['displayName'],
        email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'displayName': displayName, 'email': email, 'password': password};
  }
}
