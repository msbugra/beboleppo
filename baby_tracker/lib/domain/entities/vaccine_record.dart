class VaccineRecord {
  final String id;
  final String babyId;
  final String vaccineName;
  final DateTime scheduledDate;
  final DateTime? administeredDate;
  final bool completed;
  final String? location;
  final String? notes;
  final DateTime createdAt;

  const VaccineRecord({
    required this.id,
    required this.babyId,
    required this.vaccineName,
    required this.scheduledDate,
    this.administeredDate,
    required this.completed,
    this.location,
    this.notes,
    required this.createdAt,
  });

  VaccineRecord copyWith({
    String? id,
    String? babyId,
    String? vaccineName,
    DateTime? scheduledDate,
    DateTime? administeredDate,
    bool? completed,
    String? location,
    String? notes,
    DateTime? createdAt,
  }) {
    return VaccineRecord(
      id: id ?? this.id,
      babyId: babyId ?? this.babyId,
      vaccineName: vaccineName ?? this.vaccineName,
      scheduledDate: scheduledDate ?? this.scheduledDate,
      administeredDate: administeredDate ?? this.administeredDate,
      completed: completed ?? this.completed,
      location: location ?? this.location,
      notes: notes ?? this.notes,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is VaccineRecord &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          babyId == other.babyId &&
          vaccineName == other.vaccineName &&
          scheduledDate == other.scheduledDate &&
          administeredDate == other.administeredDate &&
          completed == other.completed;

  @override
  int get hashCode =>
      id.hashCode ^
      babyId.hashCode ^
      vaccineName.hashCode ^
      scheduledDate.hashCode ^
      administeredDate.hashCode ^
      completed.hashCode;

  @override
  String toString() {
    return 'VaccineRecord{id: $id, babyId: $babyId, vaccineName: $vaccineName, scheduledDate: $scheduledDate, completed: $completed}';
  }
}