import 'package:zero_waste_application/models/user.dart';

class Post {
  final int id;
  final String name;
  final User user;

  Post({
    required this.id,
    required this.name,
    required this.user,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'], name: json['name'], user: User.fromJson(json['user']));
  }
}
