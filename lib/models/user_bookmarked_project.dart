class UserBookmarkedProject {
  final int id;
  final int UserId;
  final int ProjectId;
  final DateTime createdAt;
  final DateTime updatedAt;

  UserBookmarkedProject({
    required this.id,
    required this.UserId,
    required this.ProjectId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory UserBookmarkedProject.fromJson(Map<String, dynamic> json) {
    return UserBookmarkedProject(
        id: json['id'],
        ProjectId: json['ProjectId'],
        UserId: json['UserId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}
