// ignore_for_file: non_constant_identifier_names, library_prefixes

import 'package:zero_waste_application/models/user.dart' as AppUser;

class Post {
  final int id;
  final String title;
  final String description;
  final String image;
  final int UserId;
  final DateTime createdAt;
  final DateTime updatedAt;
  final AppUser.User User;

  Post(
      {required this.id,
      required this.title,
      required this.description,
      required this.image,
      required this.UserId,
      required this.createdAt,
      required this.updatedAt,
      required this.User});

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        image: json['image'],
        UserId: json['UserId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt'],
        User: AppUser.User.fromJson(json['User']));
  }
}
