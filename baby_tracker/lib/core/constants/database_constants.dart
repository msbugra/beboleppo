class DatabaseConstants {
  // Table names
  static const String motherTable = 'mothers';
  static const String babyTable = 'babies';
  static const String healthRecordTable = 'health_records';
  static const String vaccineRecordTable = 'vaccine_records';
  static const String growthMeasurementTable = 'growth_measurements';
  static const String recommendationTable = 'recommendations';
  static const String culturalTraditionTable = 'cultural_traditions';
  static const String milestoneTable = 'milestones';
  static const String sleepRecordTable = 'sleep_records';
  static const String nutritionRecordTable = 'nutrition_records';
  
  // Common fields
  static const String id = 'id';
  static const String createdAt = 'created_at';
  static const String updatedAt = 'updated_at';
  
  // Mother table fields
  static const String motherName = 'name';
  static const String motherBirthDate = 'birth_date';
  static const String motherBirthCity = 'birth_city';
  static const String astrologyEnabled = 'astrology_enabled';
  
  // Baby table fields
  static const String motherId = 'mother_id';
  static const String babyName = 'name';
  static const String babyBirthDate = 'birth_date';
  static const String babyBirthTime = 'birth_time';
  static const String birthWeight = 'birth_weight';
  static const String birthHeight = 'birth_height';
  static const String birthHeadCircumference = 'birth_head_circumference';
  static const String birthCity = 'birth_city';
  
  // Health record fields
  static const String babyId = 'baby_id';
  static const String recordType = 'record_type';
  static const String recordDate = 'record_date';
  static const String recordData = 'record_data';
  static const String notes = 'notes';
  
  // Growth measurement fields
  static const String measurementDate = 'measurement_date';
  static const String weight = 'weight';
  static const String height = 'height';
  static const String headCircumference = 'head_circumference';
  static const String percentileWeight = 'percentile_weight';
  static const String percentileHeight = 'percentile_height';
  static const String percentileHeadCircumference = 'percentile_head_circumference';
  
  // Vaccine record fields
  static const String vaccineName = 'vaccine_name';
  static const String scheduledDate = 'scheduled_date';
  static const String administeredDate = 'administered_date';
  static const String completed = 'completed';
  static const String location = 'location';
  
  // Recommendation fields
  static const String ageInDays = 'age_in_days';
  static const String category = 'category';
  static const String title = 'title';
  static const String description = 'description';
  static const String scientificBasis = 'scientific_basis';
  static const String isActive = 'is_active';
}