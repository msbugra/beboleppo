import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/baby.dart';
import '../../domain/repositories/baby_repository.dart';
import '../datasources/database_helper.dart';
import '../models/baby_model.dart';
import '../../core/constants/database_constants.dart';

class BabyRepositoryImpl implements BabyRepository {
  final DatabaseHelper databaseHelper;

  BabyRepositoryImpl({required this.databaseHelper});

  @override
  Future<Either<Failure, Baby>> createBaby(Baby baby) async {
    try {
      final db = await databaseHelper.database;
      final babyModel = BabyModel.fromEntity(baby);
      
      await db.insert(
        DatabaseConstants.babyTable,
        babyModel.toMap(),
      );
      
      return Right(baby);
    } catch (e) {
      return Left(DatabaseFailure('Failed to create baby: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Baby?>> getBaby(String motherId) async {
    try {
      final db = await databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseConstants.babyTable,
        where: '${DatabaseConstants.motherId} = ?',
        whereArgs: [motherId],
        limit: 1,
      );
      
      if (maps.isEmpty) {
        return const Right(null);
      }
      
      final baby = BabyModel.fromMap(maps.first);
      return Right(baby);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get baby: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Baby>>> getBabies(String motherId) async {
    try {
      final db = await databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseConstants.babyTable,
        where: '${DatabaseConstants.motherId} = ?',
        whereArgs: [motherId],
        orderBy: '${DatabaseConstants.createdAt} ASC',
      );
      
      final babies = maps.map((map) => BabyModel.fromMap(map)).toList();
      return Right(babies);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get babies: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Baby>> updateBaby(Baby baby) async {
    try {
      final db = await databaseHelper.database;
      final babyModel = BabyModel.fromEntity(baby);
      
      final count = await db.update(
        DatabaseConstants.babyTable,
        babyModel.toMap(),
        where: '${DatabaseConstants.id} = ?',
        whereArgs: [baby.id],
      );
      
      if (count == 0) {
        return const Left(DatabaseFailure('Baby not found'));
      }
      
      return Right(baby);
    } catch (e) {
      return Left(DatabaseFailure('Failed to update baby: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteBaby(String id) async {
    try {
      final db = await databaseHelper.database;
      
      final count = await db.delete(
        DatabaseConstants.babyTable,
        where: '${DatabaseConstants.id} = ?',
        whereArgs: [id],
      );
      
      if (count == 0) {
        return const Left(DatabaseFailure('Baby not found'));
      }
      
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete baby: ${e.toString()}'));
    }
  }
}