import '../../domain/entities/growth_measurement.dart';
import '../../core/constants/database_constants.dart';

class GrowthMeasurementModel extends GrowthMeasurement {
  const GrowthMeasurementModel({
    required super.id,
    required super.babyId,
    required super.measurementDate,
    super.weight,
    super.height,
    super.headCircumference,
    super.percentileWeight,
    super.percentileHeight,
    super.percentileHeadCircumference,
    super.notes,
    required super.createdAt,
  });

  factory GrowthMeasurementModel.fromEntity(GrowthMeasurement measurement) {
    return GrowthMeasurementModel(
      id: measurement.id,
      babyId: measurement.babyId,
      measurementDate: measurement.measurementDate,
      weight: measurement.weight,
      height: measurement.height,
      headCircumference: measurement.headCircumference,
      percentileWeight: measurement.percentileWeight,
      percentileHeight: measurement.percentileHeight,
      percentileHeadCircumference: measurement.percentileHeadCircumference,
      notes: measurement.notes,
      createdAt: measurement.createdAt,
    );
  }

  factory GrowthMeasurementModel.fromMap(Map<String, dynamic> map) {
    return GrowthMeasurementModel(
      id: map[DatabaseConstants.id] as String,
      babyId: map[DatabaseConstants.babyId] as String,
      measurementDate: DateTime.parse(
        map[DatabaseConstants.measurementDate] as String,
      ),
      weight: map[DatabaseConstants.weight] != null
          ? (map[DatabaseConstants.weight] as num).toDouble()
          : null,
      height: map[DatabaseConstants.height] != null
          ? (map[DatabaseConstants.height] as num).toDouble()
          : null,
      headCircumference: map[DatabaseConstants.headCircumference] != null
          ? (map[DatabaseConstants.headCircumference] as num).toDouble()
          : null,
      percentileWeight: map[DatabaseConstants.percentileWeight] as int?,
      percentileHeight: map[DatabaseConstants.percentileHeight] as int?,
      percentileHeadCircumference:
          map[DatabaseConstants.percentileHeadCircumference] as int?,
      notes: map[DatabaseConstants.notes] as String?,
      createdAt: DateTime.parse(map[DatabaseConstants.createdAt] as String),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      DatabaseConstants.id: id,
      DatabaseConstants.babyId: babyId,
      DatabaseConstants.measurementDate: measurementDate.toIso8601String(),
      DatabaseConstants.weight: weight,
      DatabaseConstants.height: height,
      DatabaseConstants.headCircumference: headCircumference,
      DatabaseConstants.percentileWeight: percentileWeight,
      DatabaseConstants.percentileHeight: percentileHeight,
      DatabaseConstants.percentileHeadCircumference:
          percentileHeadCircumference,
      DatabaseConstants.notes: notes,
      DatabaseConstants.createdAt: createdAt.toIso8601String(),
    };
  }
}
