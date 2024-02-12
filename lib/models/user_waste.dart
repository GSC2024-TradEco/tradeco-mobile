class Post {
  final int id;
  final String name;
  final int UserId;

  Post({
    required this.id,
    required this.name,
    required this.UserId,
  });

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(id: json['id'], name: json['name'], UserId: json['user']);
  }
}
