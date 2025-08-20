import 'package:injectable/injectable.dart';

abstract class HomeRemoteDatasource {
  Future<void> firstMethod(String data);
}

@LazySingleton(as: HomeRemoteDatasource)
class HomeRemoteDatasourceImpl implements HomeRemoteDatasource {
  final ApiService apiService;

  HomeRemoteDatasourceImpl({
    required this.apiService,
  });

  @override
  Future<void> firstMethod(String data) async {
    return await apiService.firstMethod('kAccessToken', 'accessToken');
  }
}
  