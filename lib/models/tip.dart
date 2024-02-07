class Tip {
  final int id;
  final String title;
  final String description;
  final String image;

  Tip({
    required this.id,
    required this.title,
    required this.description,
    required this.image,
  });

  factory Tip.fromJson(Map<String, dynamic> json) {
    return Tip(
        id: json['id'],
        title: json['title'],
        description: json['description'],
        image: json['image']);
  }
}
