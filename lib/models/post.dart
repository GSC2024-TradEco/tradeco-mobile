class Post {
  final int id;
  final String title;
  final String description;
  final String image;
  final int UserId;
  final DateTime createdAt;
  final DateTime updatedAt;

  Post({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
    required this.UserId,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        image: json['image'],
        UserId: json['UserId'],
        createdAt: json['createdAt'],
        updatedAt: json['updatedAt']);
  }
}
