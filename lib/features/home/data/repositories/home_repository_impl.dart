import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository {
  final HomeRemoteDatasource homeRemoteDatasource;
  final HomeLocalDatasource homeLocalDataSource;
  const HomeRepositoryImpl({
    required this.homeRemoteDatasource,
    required this.homeLocalDataSource,
  });

  @override
  Future<Either<Failure, void>> firstMethod(String data) async {
    try {

      return const Right<Failure, void>(null);
    } on DioException catch (error) {
      if (error.response!.statusCode! >= 500) {
        return Left<Failure, void>(
          ServerFailure(
            message: kServerError,
            statusCode: error.response!.statusCode,
          ),
        );
      }

      return const Left<Failure, void>(GenericFailure(message: kLoginError));
    }
  }

}
  