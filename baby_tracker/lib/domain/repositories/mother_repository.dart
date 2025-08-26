import 'package:dartz/dartz.dart';
import '../../core/error/failures.dart';
import '../entities/mother.dart';

abstract class MotherRepository {
  Future<Either<Failure, Mother>> createMother(Mother mother);
  Future<Either<Failure, Mother?>> getMother();
  Future<Either<Failure, Mother>> updateMother(Mother mother);
  Future<Either<Failure, void>> deleteMother(String id);
}