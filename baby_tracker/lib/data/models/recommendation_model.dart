import '../../domain/entities/recommendation.dart';
import '../../core/constants/database_constants.dart';

class RecommendationModel extends Recommendation {
  const RecommendationModel({
    required super.id,
    required super.ageInDays,
    required super.category,
    required super.title,
    required super.description,
    super.scientificBasis,
    required super.isActive,
    required super.createdAt,
  });

  factory RecommendationModel.fromEntity(Recommendation recommendation) {
    return RecommendationModel(
      id: recommendation.id,
      ageInDays: recommendation.ageInDays,
      category: recommendation.category,
      title: recommendation.title,
      description: recommendation.description,
      scientificBasis: recommendation.scientificBasis,
      isActive: recommendation.isActive,
      createdAt: recommendation.createdAt,
    );
  }

  factory RecommendationModel.fromMap(Map<String, dynamic> map) {
    return RecommendationModel(
      id: map[DatabaseConstants.id] as String,
      ageInDays: map[DatabaseConstants.ageInDays] as int,
      category: map[DatabaseConstants.category] as String,
      title: map[DatabaseConstants.title] as String,
      description: map[DatabaseConstants.description] as String,
      scientificBasis: map[DatabaseConstants.scientificBasis] as String?,
      isActive: (map[DatabaseConstants.isActive] as int) == 1,
      createdAt: DateTime.parse(map[DatabaseConstants.createdAt] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.id: id,
      DatabaseConstants.ageInDays: ageInDays,
      DatabaseConstants.category: category,
      DatabaseConstants.title: title,
      DatabaseConstants.description: description,
      DatabaseConstants.scientificBasis: scientificBasis,
      DatabaseConstants.isActive: isActive ? 1 : 0,
      DatabaseConstants.createdAt: createdAt.toIso8601String(),
    };
  }

  @override
  RecommendationModel copyWith({
    String? id,
    int? ageInDays,
    String? category,
    String? title,
    String? description,
    String? scientificBasis,
    bool? isActive,
    DateTime? createdAt,
  }) {
    return RecommendationModel(
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
}
