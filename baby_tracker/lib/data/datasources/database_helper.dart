import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import '../../core/constants/app_constants.dart';
import '../../core/constants/database_constants.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  static Database? _database;

  DatabaseHelper._internal();

  factory DatabaseHelper() => _instance;

  Future<Database> get database async {
    _database ??= await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, AppConstants.databaseName);

    return await openDatabase(
      path,
      version: AppConstants.databaseVersion,
      onCreate: _onCreate,
      onUpgrade: _onUpgrade,
    );
  }

  Future<void> _onCreate(Database db, int version) async {
    await _createMotherTable(db);
    await _createBabyTable(db);
    await _createHealthRecordTable(db);
    await _createVaccineRecordTable(db);
    await _createGrowthMeasurementTable(db);
    await _createRecommendationTable(db);
    await _createCulturalTraditionTable(db);
    await _createMilestoneTable(db);
    await _createSleepRecordTable(db);
    await _createNutritionRecordTable(db);
  }

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    // Handle database upgrades here
    if (oldVersion < newVersion) {
      // Add migration logic for future versions
    }
  }

  Future<void> _createMotherTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.motherTable} (
        ${DatabaseConstants.id} TEXT PRIMARY KEY,
        ${DatabaseConstants.motherName} TEXT NOT NULL,
        ${DatabaseConstants.motherBirthDate} TEXT,
        ${DatabaseConstants.motherBirthCity} TEXT,
        ${DatabaseConstants.astrologyEnabled} INTEGER NOT NULL DEFAULT 0,
        ${DatabaseConstants.createdAt} TEXT NOT NULL,
        ${DatabaseConstants.updatedAt} TEXT NOT NULL
      )
    ''');
  }

  Future<void> _createBabyTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.babyTable} (
        ${DatabaseConstants.id} TEXT PRIMARY KEY,
        ${DatabaseConstants.motherId} TEXT NOT NULL,
        ${DatabaseConstants.babyName} TEXT NOT NULL,
        ${DatabaseConstants.babyBirthDate} TEXT NOT NULL,
        ${DatabaseConstants.babyBirthTime} TEXT,
        ${DatabaseConstants.birthWeight} REAL NOT NULL,
        ${DatabaseConstants.birthHeight} REAL NOT NULL,
        ${DatabaseConstants.birthHeadCircumference} REAL NOT NULL,
        ${DatabaseConstants.birthCity} TEXT,
        ${DatabaseConstants.createdAt} TEXT NOT NULL,
        ${DatabaseConstants.updatedAt} TEXT NOT NULL,
        FOREIGN KEY (${DatabaseConstants.motherId}) REFERENCES ${DatabaseConstants.motherTable}(${DatabaseConstants.id})
      )
    ''');
  }

  Future<void> _createHealthRecordTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.healthRecordTable} (
        ${DatabaseConstants.id} TEXT PRIMARY KEY,
        ${DatabaseConstants.babyId} TEXT NOT NULL,
        ${DatabaseConstants.recordType} TEXT NOT NULL,
        ${DatabaseConstants.recordDate} TEXT NOT NULL,
        ${DatabaseConstants.recordData} TEXT,
        ${DatabaseConstants.notes} TEXT,
        ${DatabaseConstants.createdAt} TEXT NOT NULL,
        FOREIGN KEY (${DatabaseConstants.babyId}) REFERENCES ${DatabaseConstants.babyTable}(${DatabaseConstants.id})
      )
    ''');
  }

  Future<void> _createVaccineRecordTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.vaccineRecordTable} (
        ${DatabaseConstants.id} TEXT PRIMARY KEY,
        ${DatabaseConstants.babyId} TEXT NOT NULL,
        ${DatabaseConstants.vaccineName} TEXT NOT NULL,
        ${DatabaseConstants.scheduledDate} TEXT NOT NULL,
        ${DatabaseConstants.administeredDate} TEXT,
        ${DatabaseConstants.completed} INTEGER NOT NULL DEFAULT 0,
        ${DatabaseConstants.location} TEXT,
        ${DatabaseConstants.notes} TEXT,
        ${DatabaseConstants.createdAt} TEXT NOT NULL,
        FOREIGN KEY (${DatabaseConstants.babyId}) REFERENCES ${DatabaseConstants.babyTable}(${DatabaseConstants.id})
      )
    ''');
  }

  Future<void> _createGrowthMeasurementTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.growthMeasurementTable} (
        ${DatabaseConstants.id} TEXT PRIMARY KEY,
        ${DatabaseConstants.babyId} TEXT NOT NULL,
        ${DatabaseConstants.measurementDate} TEXT NOT NULL,
        ${DatabaseConstants.weight} REAL,
        ${DatabaseConstants.height} REAL,
        ${DatabaseConstants.headCircumference} REAL,
        ${DatabaseConstants.percentileWeight} INTEGER,
        ${DatabaseConstants.percentileHeight} INTEGER,
        ${DatabaseConstants.percentileHeadCircumference} INTEGER,
        ${DatabaseConstants.notes} TEXT,
        ${DatabaseConstants.createdAt} TEXT NOT NULL,
        FOREIGN KEY (${DatabaseConstants.babyId}) REFERENCES ${DatabaseConstants.babyTable}(${DatabaseConstants.id})
      )
    ''');
  }

  Future<void> _createRecommendationTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.recommendationTable} (
        ${DatabaseConstants.id} TEXT PRIMARY KEY,
        ${DatabaseConstants.ageInDays} INTEGER NOT NULL,
        ${DatabaseConstants.category} TEXT NOT NULL,
        ${DatabaseConstants.title} TEXT NOT NULL,
        ${DatabaseConstants.description} TEXT NOT NULL,
        ${DatabaseConstants.scientificBasis} TEXT,
        ${DatabaseConstants.isActive} INTEGER NOT NULL DEFAULT 1,
        ${DatabaseConstants.createdAt} TEXT NOT NULL
      )
    ''');

    // Create index for faster age-based queries
    await db.execute('''
      CREATE INDEX idx_recommendations_age_category 
      ON ${DatabaseConstants.recommendationTable}(${DatabaseConstants.ageInDays}, ${DatabaseConstants.category})
    ''');
  }

  Future<void> _createCulturalTraditionTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.culturalTraditionTable} (
        ${DatabaseConstants.id} TEXT PRIMARY KEY,
        name TEXT NOT NULL,
        culture TEXT NOT NULL,
        description TEXT NOT NULL,
        historical_background TEXT NOT NULL,
        how_to_perform TEXT NOT NULL,
        cultural_significance TEXT NOT NULL,
        modern_adaptations TEXT,
        image_urls TEXT,
        ${DatabaseConstants.isActive} INTEGER NOT NULL DEFAULT 1,
        ${DatabaseConstants.createdAt} TEXT NOT NULL
      )
    ''');
  }

  Future<void> _createMilestoneTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.milestoneTable} (
        ${DatabaseConstants.id} TEXT PRIMARY KEY,
        ${DatabaseConstants.babyId} TEXT NOT NULL,
        milestone_type TEXT NOT NULL,
        milestone_name TEXT NOT NULL,
        expected_age_days INTEGER NOT NULL,
        achieved_date TEXT,
        achieved INTEGER NOT NULL DEFAULT 0,
        ${DatabaseConstants.notes} TEXT,
        ${DatabaseConstants.createdAt} TEXT NOT NULL,
        FOREIGN KEY (${DatabaseConstants.babyId}) REFERENCES ${DatabaseConstants.babyTable}(${DatabaseConstants.id})
      )
    ''');
  }

  Future<void> _createSleepRecordTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.sleepRecordTable} (
        ${DatabaseConstants.id} TEXT PRIMARY KEY,
        ${DatabaseConstants.babyId} TEXT NOT NULL,
        sleep_date TEXT NOT NULL,
        bedtime TEXT,
        wake_time TEXT,
        duration_minutes INTEGER,
        quality_rating INTEGER,
        ${DatabaseConstants.notes} TEXT,
        ${DatabaseConstants.createdAt} TEXT NOT NULL,
        FOREIGN KEY (${DatabaseConstants.babyId}) REFERENCES ${DatabaseConstants.babyTable}(${DatabaseConstants.id})
      )
    ''');
  }

  Future<void> _createNutritionRecordTable(Database db) async {
    await db.execute('''
      CREATE TABLE ${DatabaseConstants.nutritionRecordTable} (
        ${DatabaseConstants.id} TEXT PRIMARY KEY,
        ${DatabaseConstants.babyId} TEXT NOT NULL,
        feeding_date TEXT NOT NULL,
        feeding_type TEXT NOT NULL,
        amount_ml REAL,
        duration_minutes INTEGER,
        food_type TEXT,
        ${DatabaseConstants.notes} TEXT,
        ${DatabaseConstants.createdAt} TEXT NOT NULL,
        FOREIGN KEY (${DatabaseConstants.babyId}) REFERENCES ${DatabaseConstants.babyTable}(${DatabaseConstants.id})
      )
    ''');
  }

  Future<void> close() async {
    final db = await database;
    await db.close();
  }

  Future<void> deleteDatabase() async {
    final databasesPath = await getDatabasesPath();
    final path = join(databasesPath, AppConstants.databaseName);
    await databaseFactory.deleteDatabase(path);
    _database = null;
  }
}