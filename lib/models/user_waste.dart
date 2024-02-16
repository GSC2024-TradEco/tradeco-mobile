class Waste {
  final int id;
  final String name;
  final int UserId;

  Waste({
    required this.id,
    required this.name,
    required this.UserId,
  });

  factory Waste.fromJson(Map<String, dynamic> json) {
    return Waste(id: json['id'], name: json['name'], UserId: json['user']);
  }
}
