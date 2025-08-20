import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: CoreRepository)
class CoreRepositoryImpl implements CoreRepository {
  final CoreRemoteDatasource coreRemoteDatasource;
  final CoreLocalDatasource coreLocalDataSource;
  const CoreRepositoryImpl({
    required this.coreRemoteDatasource,
    required this.coreLocalDataSource,
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
  