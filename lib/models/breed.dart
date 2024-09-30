class Breed {
  final String id;
  final String name;
  final String description;

  Breed({required this.id, required this.name, required this.description});

  factory Breed.fromJson(Map<String, dynamic> json) {
    return Breed(
      id: json['id'],
      name: json['name'],
      description: json['description'],
    );
  }

  @override
  int get hashCode {
    return id.hashCode;
  }

  @override
  bool operator ==(Object other) {
    return id == (other as Breed).id;
  }

  toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
    };
  }

  static Breed fromMap(Map<String, Object?> e) {
    return Breed(
      id: e['id'] as String,
      name: e['name'] as String,
      description: e['description'] as String,
    );
  }
}