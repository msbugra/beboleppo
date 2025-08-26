class GrowthMeasurement {
  final String id;
  final String babyId;
  final DateTime measurementDate;
  final double? weight; // in grams
  final double? height; // in centimeters
  final double? headCircumference; // in centimeters
  final int? percentileWeight;
  final int? percentileHeight;
  final int? percentileHeadCircumference;
  final String? notes;
  final DateTime createdAt;

  const GrowthMeasurement({
    required this.id,
    required this.babyId,
    required this.measurementDate,
    this.weight,
    this.height,
    this.headCircumference,
    this.percentileWeight,
    this.percentileHeight,
    this.percentileHeadCircumference,
    this.notes,
    required this.createdAt,
  });

  GrowthMeasurement copyWith({
    String? id,
    String? babyId,
    DateTime? measurementDate,
    double? weight,
    double? height,
    double? headCircumference,
    int? percentileWeight,
    int? percentileHeight,
    int? percentileHeadCircumference,
    String? notes,
    DateTime? createdAt,
  }) {
    return GrowthMeasurement(
      id: id ?? this.id,
      babyId: babyId ?? this.babyId,
      measurementDate: measurementDate ?? this.measurementDate,
      weight: weight ?? this.weight,
      height: height ?? this.height,
      headCircumference: headCircumference ?? this.headCircumference,
      percentileWeight: percentileWeight ?? this.percentileWeight,
      percentileHeight: percentileHeight ?? this.percentileHeight,
      percentileHeadCircumference: percentileHeadCircumference ?? this.percentileHeadCircumference,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is GrowthMeasurement &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          babyId == other.babyId &&
          measurementDate == other.measurementDate &&
          weight == other.weight &&
          height == other.height &&
          headCircumference == other.headCircumference;

  @override
  int get hashCode =>
      id.hashCode ^
      babyId.hashCode ^
      measurementDate.hashCode ^
      weight.hashCode ^
      height.hashCode ^
      headCircumference.hashCode;

  @override
  String toString() {
    return 'GrowthMeasurement{id: $id, babyId: $babyId, measurementDate: $measurementDate, weight: $weight, height: $height, headCircumference: $headCircumference}';
  }
}