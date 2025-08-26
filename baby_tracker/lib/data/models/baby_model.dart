import '../../domain/entities/baby.dart';
import '../../core/constants/database_constants.dart';

class BabyModel extends Baby {
  const BabyModel({
    required super.id,
    required super.motherId,
    required super.name,
    required super.birthDate,
    super.birthTime,
    required super.birthWeight,
    required super.birthHeight,
    required super.birthHeadCircumference,
    super.birthCity,
    required super.createdAt,
    required super.updatedAt,
  });

  factory BabyModel.fromEntity(Baby baby) {
    return BabyModel(
      id: baby.id,
      motherId: baby.motherId,
      name: baby.name,
      birthDate: baby.birthDate,
      birthTime: baby.birthTime,
      birthWeight: baby.birthWeight,
      birthHeight: baby.birthHeight,
      birthHeadCircumference: baby.birthHeadCircumference,
      birthCity: baby.birthCity,
      createdAt: baby.createdAt,
      updatedAt: baby.updatedAt,
    );
  }

  factory BabyModel.fromMap(Map<String, dynamic> map) {
    return BabyModel(
      id: map[DatabaseConstants.id] as String,
      motherId: map[DatabaseConstants.motherId] as String,
      name: map[DatabaseConstants.babyName] as String,
      birthDate: DateTime.parse(map[DatabaseConstants.babyBirthDate] as String),
      birthTime: map[DatabaseConstants.babyBirthTime] as String?,
      birthWeight: (map[DatabaseConstants.birthWeight] as num).toDouble(),
      birthHeight: (map[DatabaseConstants.birthHeight] as num).toDouble(),
      birthHeadCircumference:
          (map[DatabaseConstants.birthHeadCircumference] as num).toDouble(),
      birthCity: map[DatabaseConstants.birthCity] as String?,
      createdAt: DateTime.parse(map[DatabaseConstants.createdAt] as String),
      updatedAt: DateTime.parse(map[DatabaseConstants.updatedAt] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.id: id,
      DatabaseConstants.motherId: motherId,
      DatabaseConstants.babyName: name,
      DatabaseConstants.babyBirthDate: birthDate.toIso8601String(),
      DatabaseConstants.babyBirthTime: birthTime,
      DatabaseConstants.birthWeight: birthWeight,
      DatabaseConstants.birthHeight: birthHeight,
      DatabaseConstants.birthHeadCircumference: birthHeadCircumference,
      DatabaseConstants.birthCity: birthCity,
      DatabaseConstants.createdAt: createdAt.toIso8601String(),
      DatabaseConstants.updatedAt: updatedAt.toIso8601String(),
    };
  }

  @override
  BabyModel copyWith({
    String? id,
    String? motherId,
    String? name,
    DateTime? birthDate,
    String? birthTime,
    double? birthWeight,
    double? birthHeight,
    double? birthHeadCircumference,
    String? birthCity,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return BabyModel(
      id: id ?? this.id,
      motherId: motherId ?? this.motherId,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      birthTime: birthTime ?? this.birthTime,
      birthWeight: birthWeight ?? this.birthWeight,
      birthHeight: birthHeight ?? this.birthHeight,
      birthHeadCircumference:
          birthHeadCircumference ?? this.birthHeadCircumference,
      birthCity: birthCity ?? this.birthCity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
