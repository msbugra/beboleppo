import '../../domain/entities/mother.dart';
import '../../core/constants/database_constants.dart';

class MotherModel extends Mother {
  const MotherModel({
    required super.id,
    required super.name,
    super.birthDate,
    super.birthCity,
    required super.astrologyEnabled,
    required super.createdAt,
    required super.updatedAt,
  });

  factory MotherModel.fromEntity(Mother mother) {
    return MotherModel(
      id: mother.id,
      name: mother.name,
      birthDate: mother.birthDate,
      birthCity: mother.birthCity,
      astrologyEnabled: mother.astrologyEnabled,
      createdAt: mother.createdAt,
      updatedAt: mother.updatedAt,
    );
  }

  factory MotherModel.fromMap(Map<String, dynamic> map) {
    return MotherModel(
      id: map[DatabaseConstants.id] as String,
      name: map[DatabaseConstants.motherName] as String,
      birthDate: map[DatabaseConstants.motherBirthDate] != null
          ? DateTime.parse(map[DatabaseConstants.motherBirthDate] as String)
          : null,
      birthCity: map[DatabaseConstants.motherBirthCity] as String?,
      astrologyEnabled: (map[DatabaseConstants.astrologyEnabled] as int) == 1,
      createdAt: DateTime.parse(map[DatabaseConstants.createdAt] as String),
      updatedAt: DateTime.parse(map[DatabaseConstants.updatedAt] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.id: id,
      DatabaseConstants.motherName: name,
      DatabaseConstants.motherBirthDate: birthDate?.toIso8601String(),
      DatabaseConstants.motherBirthCity: birthCity,
      DatabaseConstants.astrologyEnabled: astrologyEnabled ? 1 : 0,
      DatabaseConstants.createdAt: createdAt.toIso8601String(),
      DatabaseConstants.updatedAt: updatedAt.toIso8601String(),
    };
  }

  @override
  MotherModel copyWith({
    String? id,
    String? name,
    DateTime? birthDate,
    String? birthCity,
    bool? astrologyEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return MotherModel(
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      birthCity: birthCity ?? this.birthCity,
      astrologyEnabled: astrologyEnabled ?? this.astrologyEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }
}
