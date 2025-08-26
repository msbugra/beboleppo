class Mother {
  final String id;
  final String name;
  final DateTime? birthDate;
  final String? birthCity;
  final bool astrologyEnabled;
  final DateTime createdAt;
  final DateTime updatedAt;

  const Mother({
    required this.id,
    required this.name,
    this.birthDate,
    this.birthCity,
    required this.astrologyEnabled,
    required this.createdAt,
    required this.updatedAt,
  });

  Mother copyWith({
    String? id,
    String? name,
    DateTime? birthDate,
    String? birthCity,
    bool? astrologyEnabled,
    DateTime? createdAt,
    DateTime? updatedAt,
  }) {
    return Mother(
      id: id ?? this.id,
      name: name ?? this.name,
      birthDate: birthDate ?? this.birthDate,
      birthCity: birthCity ?? this.birthCity,
      astrologyEnabled: astrologyEnabled ?? this.astrologyEnabled,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is Mother &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          name == other.name &&
          birthDate == other.birthDate &&
          birthCity == other.birthCity &&
          astrologyEnabled == other.astrologyEnabled;

  @override
  int get hashCode =>
      id.hashCode ^
      name.hashCode ^
      birthDate.hashCode ^
      birthCity.hashCode ^
      astrologyEnabled.hashCode;

  @override
  String toString() {
    return 'Mother{id: $id, name: $name, birthDate: $birthDate, birthCity: $birthCity, astrologyEnabled: $astrologyEnabled}';
  }
}