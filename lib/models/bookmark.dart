import 'package:zero_waste_application/models/user.dart';
import 'package:zero_waste_application/models/project.dart';

class Bookmark {
  final int id;
  final User user;
  final Project project;

  Bookmark({
    required this.id,
    required this.user,
    required this.project,
  });

  factory Bookmark.fromJson(Map<String, dynamic> json) {
    return Bookmark(
        id: json['id'],
        project: Project.fromJson(json['bookmark']),
        user: User.fromJson(json['user']));
  }
}
