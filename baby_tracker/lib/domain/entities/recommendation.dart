class Recommendation {
  final String id;
  final int ageInDays;
  final String category;
  final String title;
  final String description;
  final String? scientificBasis;
  final bool isActive;
  final DateTime createdAt;

  const Recommendation({
    required this.id,
    required this.ageInDays,
    required this.category,
    required this.title,
    required this.description,
    this.scientificBasis,
    required this.isActive,
    required this.createdAt,
  });

  Recommendation copyWith({
    String? id,
    int? ageInDays,
    String? category,
    String? title,
    String? description,
    String? scientificBasis,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return Recommendation(
      id: id ?? this.id,
      ageInDays: ageInDays ?? this.ageInDays,
      category: category ?? this.category,
      title: title ?? this.title,
      description: description ?? this.description,
      scientificBasis: scientificBasis ?? this.scientificBasis,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Recommendation &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          ageInDays == other.ageInDays &&
          category == other.category &&
          title == other.title &&
          description == other.description &&
          scientificBasis == other.scientificBasis &&
          isActive == other.isActive;

  @override
  int get hashCode =>
      id.hashCode ^
      ageInDays.hashCode ^
      category.hashCode ^
      title.hashCode ^
      description.hashCode ^
      scientificBasis.hashCode ^
      isActive.hashCode;

  @override
  String toString() {
    return 'Recommendation{id: $id, ageInDays: $ageInDays, category: $category, title: $title, isActive: $isActive}';
  }
}