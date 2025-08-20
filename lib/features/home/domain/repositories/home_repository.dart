import 'package:dartz/dartz.dart';

abstract class HomeRepository {
  Future<Either<Failure, void>> firstMethod(String data);
}
  