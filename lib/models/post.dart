import 'package:zero_waste_application/models/user.dart';

class Post {
  final int id;
  final String title;
  final String description;
  final String image;
  final User user;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.user,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        image: json['image'],
        user: User.fromJson(json['user']));
  }
}
