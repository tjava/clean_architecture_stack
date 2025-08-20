import 'package:dartz/dartz.dart';

abstract class CoreRepository {
  Future<Either<Failure, void>> firstMethod(String data);
}
  