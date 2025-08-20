import 'package:injectable/injectable.dart';

abstract class CoreRemoteDatasource {
  Future<void> firstMethod(String data);
}

@LazySingleton(as: CoreRemoteDatasource)
class CoreRemoteDatasourceImpl implements CoreRemoteDatasource {
  final ApiService apiService;

  CoreRemoteDatasourceImpl({
    required this.apiService,
  });

  @override
  Future<void> firstMethod(String data) async {
    return await apiService.firstMethod('kAccessToken', 'accessToken');
  }
}
  