import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/growth_measurement.dart';

abstract class GrowthRepository {
  Future<Either<Failure, GrowthMeasurement>> addGrowthMeasurement(GrowthMeasurement measurement);
  Future<Either<Failure, List<GrowthMeasurement>>> getGrowthMeasurements(String babyId);
  Future<Either<Failure, GrowthMeasurement?>> getLatestGrowthMeasurement(String babyId);
  Future<Either<Failure, GrowthMeasurement>> updateGrowthMeasurement(GrowthMeasurement measurement);
  Future<Either<Failure, void>> deleteGrowthMeasurement(String id);
}