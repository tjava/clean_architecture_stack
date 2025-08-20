import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class HomeLocalDatasource {
  Future<void> firstMethod(String data);
}

@LazySingleton(as: HomeLocalDatasource)
class HomeLocalDatasourceImpl implements HomeLocalDatasource {
  final SharedPreferences sharedPreferences;

  HomeLocalDatasourceImpl({
    required this.sharedPreferences,
  });

  @override
  Future<void> firstMethod(String data) async {
    try {
      return await sharedPreferences.setString('kAccessToken', 'accessToken');
    } catch (e) {
      throw CacheException(message: e.toString());
    }
  }
}
  