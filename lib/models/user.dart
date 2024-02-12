class User {
  final int id;
  final String uid;
  final String email;
  final String displayName;
  final String instagram;
  final double longitude;
  final double latitude;
  final DateTime createdAt;
  final DateTime updatedAt;

  User({
    required this.id,
    required this.uid,
    required this.email,
    required this.displayName,
    required this.instagram,
    required this.longitude,
    required this.latitude,
    required this.createdAt,
    required this.updatedAt,
  });

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      uid: json['uid'],
      email: json['email'],
      displayName: json['displayName'],
      instagram: json['instagram'],
      longitude: json['longitude'],
      latitude: json['latitude'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
