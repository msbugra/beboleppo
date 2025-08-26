import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/baby.dart';

abstract class BabyRepository {
  Future<Either<Failure, Baby>> createBaby(Baby baby);
  Future<Either<Failure, Baby?>> getBaby(String motherId);
  Future<Either<Failure, List<Baby>>> getBabies(String motherId);
  Future<Either<Failure, Baby>> updateBaby(Baby baby);
  Future<Either<Failure, void>> deleteBaby(String id);
}