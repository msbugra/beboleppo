import '../../domain/entities/cultural_tradition.dart';

class CulturalTraditionModel extends CulturalTradition {
  const CulturalTraditionModel({
    required super.id,
    required super.name,
    required super.culture,
    required super.description,
    required super.historicalBackground,
    required super.howToPerform,
    required super.culturalSignificance,
    super.modernAdaptations,
    super.imageUrls,
    required super.isActive,
    required super.createdAt,
  });

  factory CulturalTraditionModel.fromEntity(CulturalTradition tradition) {
    return CulturalTraditionModel(
      id: tradition.id,
      name: tradition.name,
      culture: tradition.culture,
      description: tradition.description,
      historicalBackground: tradition.historicalBackground,
      howToPerform: tradition.howToPerform,
      culturalSignificance: tradition.culturalSignificance,
      modernAdaptations: tradition.modernAdaptations,
      imageUrls: tradition.imageUrls,
      isActive: tradition.isActive,
      createdAt: tradition.createdAt,
    );
  }

  factory CulturalTraditionModel.fromMap(Map<String, dynamic> map) {
    return CulturalTraditionModel(
      id: map['id'] as String,
      name: map['name'] as String,
      culture: map['culture'] as String,
      description: map['description'] as String,
      historicalBackground: map['historical_background'] as String,
      howToPerform: map['how_to_perform'] as String,
      culturalSignificance: map['cultural_significance'] as String,
      modernAdaptations: map['modern_adaptations'] as String?,
      imageUrls: map['image_urls'] != null
          ? (map['image_urls'] as String).split(',')
          : null,
      isActive: (map['is_active'] as int) == 1,
      createdAt: DateTime.parse(map['created_at'] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'culture': culture,
      'description': description,
      'historical_background': historicalBackground,
      'how_to_perform': howToPerform,
      'cultural_significance': culturalSignificance,
      'modern_adaptations': modernAdaptations,
      'image_urls': imageUrls?.join(','),
      'is_active': isActive ? 1 : 0,
      'created_at': createdAt.toIso8601String(),
    };
  }
}
