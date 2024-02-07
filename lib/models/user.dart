class User {
  final int id;
  final String uid;
  final String displayName;
  final String email;

  User(
      {required this.id,
      required this.uid,
      required this.displayName,
      required this.email});

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
        id: json['id'],
        uid: json['uid'],
        displayName: json['displayName'],
        email: json['email']);
  }

  Map<String, dynamic> toJson() {
    return {'uid': uid, 'displayName': displayName, 'email': email};
  }
}
