import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../../domain/entities/recommendation.dart';
import '../../domain/repositories/recommendation_repository.dart';
import '../datasources/database_helper.dart';
import '../models/recommendation_model.dart';
import '../../core/constants/database_constants.dart';

class RecommendationRepositoryImpl implements RecommendationRepository {
  final DatabaseHelper databaseHelper;

  RecommendationRepositoryImpl({required this.databaseHelper});

  @override
  Future<Either<Failure, List<Recommendation>>> getRecommendationsForAge(
    int ageInDays, {
    String? category,
  }) async {
    try {
      final db = await databaseHelper.database;
      
      String whereClause = '${DatabaseConstants.ageInDays} = ? AND ${DatabaseConstants.isActive} = 1';
      List<dynamic> whereArgs = [ageInDays];
      
      if (category != null) {
        whereClause += ' AND ${DatabaseConstants.category} = ?';
        whereArgs.add(category);
      }
      
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseConstants.recommendationTable,
        where: whereClause,
        whereArgs: whereArgs,
        orderBy: '${DatabaseConstants.category} ASC, ${DatabaseConstants.title} ASC',
      );
      
      final recommendations = maps.map((map) => RecommendationModel.fromMap(map)).toList();
      return Right(recommendations);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get recommendations: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Recommendation>>> getRecommendationsByCategory(String category) async {
    try {
      final db = await databaseHelper.database;
      
      final List<Map<String, dynamic>> maps = await db.query(
        DatabaseConstants.recommendationTable,
        where: '${DatabaseConstants.category} = ? AND ${DatabaseConstants.isActive} = 1',
        whereArgs: [category],
        orderBy: '${DatabaseConstants.ageInDays} ASC, ${DatabaseConstants.title} ASC',
      );
      
      final recommendations = maps.map((map) => RecommendationModel.fromMap(map)).toList();
      return Right(recommendations);
    } catch (e) {
      return Left(DatabaseFailure('Failed to get recommendations by category: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, Recommendation>> createRecommendation(Recommendation recommendation) async {
    try {
      final db = await databaseHelper.database;
      final recommendationModel = RecommendationModel.fromEntity(recommendation);
      
      await db.insert(
        DatabaseConstants.recommendationTable,
        recommendationModel.toMap(),
      );
      
      return Right(recommendation);
    } catch (e) {
      return Left(DatabaseFailure('Failed to create recommendation: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, List<Recommendation>>> createRecommendations(List<Recommendation> recommendations) async {
    try {
      final db = await databaseHelper.database;
      
      await db.transaction((txn) async {
        for (final recommendation in recommendations) {
          final recommendationModel = RecommendationModel.fromEntity(recommendation);
          await txn.insert(
            DatabaseConstants.recommendationTable,
            recommendationModel.toMap(),
          );
        }
      });
      
      return Right(recommendations);
    } catch (e) {
      return Left(DatabaseFailure('Failed to create recommendations: ${e.toString()}'));
    }
  }

  @override
  Future<Either<Failure, void>> deleteAllRecommendations() async {
    try {
      final db = await databaseHelper.database;
      
      await db.delete(DatabaseConstants.recommendationTable);
      
      return const Right(null);
    } catch (e) {
      return Left(DatabaseFailure('Failed to delete recommendations: ${e.toString()}'));
    }
  }
}