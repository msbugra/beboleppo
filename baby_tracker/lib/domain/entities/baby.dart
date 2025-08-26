class Baby {
  final String id;
  final String motherId;
  final String name;
  final DateTime birthDate;
  final String? birthTime;
  final double birthWeight; // in grams
  final double birthHeight; // in centimeters
  final double birthHeadCircumference; // in centimeters
  final String? birthCity;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Baby({
    required this.id,
    required this.motherId,
    required this.name,
    required this.birthDate,
    this.birthTime,
    required this.birthWeight,
    required this.birthHeight,
    required this.birthHeadCircumference,
    this.birthCity,
    required this.createdAt,
    required this.updatedAt,
  });

  Baby copyWith({
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
    return Baby(
      id: id ?? this.id,
      motherId: motherId ?? this.motherId,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      birthTime: birthTime ?? this.birthTime,
      birthWeight: birthWeight ?? this.birthWeight,
      birthHeight: birthHeight ?? this.birthHeight,
      birthHeadCircumference: birthHeadCircumference ?? this.birthHeadCircumference,
      birthCity: birthCity ?? this.birthCity,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Baby &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          motherId == other.motherId &&
          name == other.name &&
          birthDate == other.birthDate &&
          birthTime == other.birthTime &&
          birthWeight == other.birthWeight &&
          birthHeight == other.birthHeight &&
          birthHeadCircumference == other.birthHeadCircumference &&
          birthCity == other.birthCity;

  @override
  int get hashCode =>
      id.hashCode ^
      motherId.hashCode ^
      name.hashCode ^
      birthDate.hashCode ^
      birthTime.hashCode ^
      birthWeight.hashCode ^
      birthHeight.hashCode ^
      birthHeadCircumference.hashCode ^
      birthCity.hashCode;

  @override
  String toString() {
    return 'Baby{id: $id, motherId: $motherId, name: $name, birthDate: $birthDate, birthWeight: $birthWeight, birthHeight: $birthHeight, birthHeadCircumference: $birthHeadCircumference}';
  }
}