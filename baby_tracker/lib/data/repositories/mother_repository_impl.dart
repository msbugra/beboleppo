import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/mother.dart';
import '../../domain/repositories/mother_repository.dart';
import '../datasources/database_helper.dart';
import '../models/mother_model.dart';
import '../../core/constants/database_constants.dart';

class MotherRepositoryImpl implements MotherRepository {
  final DatabaseHelper databaseHelper;

  MotherRepositoryImpl({required this.databaseHelper});

  @override
  Future<Either<Failure, Mother>> createMother(Mother mother) async {
    try {
      final db = await databaseHelper.database;
      final motherModel = MotherModel.fromEntity(mother);
      
      await db.insert(
        DatabaseConstants.motherTable,
        motherModel.toMap(),
      );
      
      return Right(mother);
    } catch (e) {
      return Left(DatabaseFailure('Failed to create mother: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Mother?>> getMother() async {
    try {
      final db = await databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseConstants.motherTable,
        limit: 1,
      );
      
      if (maps.isEmpty) {
        return const Right(null);
      }
      
      final mother = MotherModel.fromMap(maps.first);
      return Right(mother);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get mother: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Mother>> updateMother(Mother mother) async {
    try {
      final db = await databaseHelper.database;
      final motherModel = MotherModel.fromEntity(mother);
      
      final count = await db.update(
        DatabaseConstants.motherTable,
        motherModel.toMap(),
        where: '${DatabaseConstants.id} = ?',
        whereArgs: [mother.id],
      );
      
      if (count == 0) {
        return const Left(DatabaseFailure('Mother not found'));
      }
      
      return Right(mother);
    } catch (e) {
      return Left(DatabaseFailure('Failed to update mother: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteMother(String id) async {
    try {
      final db = await databaseHelper.database;
      
      final count = await db.delete(
        DatabaseConstants.motherTable,
        where: '${DatabaseConstants.id} = ?',
        whereArgs: [id],
      );
      
      if (count == 0) {
        return const Left(DatabaseFailure('Mother not found'));
      }
      
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete mother: ${e.toString()}'));
    }
  }
}