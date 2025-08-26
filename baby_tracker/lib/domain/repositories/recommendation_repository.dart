import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/recommendation.dart';

abstract class RecommendationRepository {
  Future<Either<Failure, List<Recommendation>>> getRecommendationsForAge(int ageInDays, {String? category});
  Future<Either<Failure, List<Recommendation>>> getRecommendationsByCategory(String category);
  Future<Either<Failure, Recommendation>> createRecommendation(Recommendation recommendation);
  Future<Either<Failure, List<Recommendation>>> createRecommendations(List<Recommendation> recommendations);
  Future<Either<Failure, void>> deleteAllRecommendations();
}