class Project {
  final int id;
  final String title;
  final String description;
  final List<String> materials;
  final List<String> steps;
  final String image;
  final String reference;
  final DateTime createdAt;
  final DateTime updatedAt;

  Project({
    required this.id,
    required this.title,
    required this.description,
    required this.materials,
    required this.steps,
    required this.image,
    required this.reference,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Project.fromJson(Map<String, dynamic> json) {
    return Project(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      materials: json['materials'],
      steps: json['steps'],
      image: json['image'],
      reference: json['reference'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }
}
