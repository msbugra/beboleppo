class CulturalTradition {
  final String id;
  final String name;
  final String culture; // 'Turkish' or country name
  final String description;
  final String historicalBackground;
  final String howToPerform;
  final String culturalSignificance;
  final String? modernAdaptations;
  final List<String>? imageUrls;
  final bool isActive;
  final DateTime createdAt;

  const CulturalTradition({
    required this.id,
    required this.name,
    required this.culture,
    required this.description,
    required this.historicalBackground,
    required this.howToPerform,
    required this.culturalSignificance,
    this.modernAdaptations,
    this.imageUrls,
    required this.isActive,
    required this.createdAt,
  });

  CulturalTradition copyWith({
    String? id,
    String? name,
    String? culture,
    String? description,
    String? historicalBackground,
    String? howToPerform,
    String? culturalSignificance,
    String? modernAdaptations,
    List<String>? imageUrls,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return CulturalTradition(
      id: id ?? this.id,
      name: name ?? this.name,
      culture: culture ?? this.culture,
      description: description ?? this.description,
      historicalBackground: historicalBackground ?? this.historicalBackground,
      howToPerform: howToPerform ?? this.howToPerform,
      culturalSignificance: culturalSignificance ?? this.culturalSignificance,
      modernAdaptations: modernAdaptations ?? this.modernAdaptations,
      imageUrls: imageUrls ?? this.imageUrls,
      isActive: isActive ?? this.isActive,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is CulturalTradition &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          culture == other.culture &&
          description == other.description;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      culture.hashCode ^
      description.hashCode;

  @override
  String toString() {
    return 'CulturalTradition{id: $id, name: $name, culture: $culture}';
  }
}