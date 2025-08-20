import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class CoreLocalDatasource {
  Future<void> firstMethod(String data);
}

@LazySingleton(as: CoreLocalDatasource)
class CoreLocalDatasourceImpl implements CoreLocalDatasource {
  final SharedPreferences sharedPreferences;

  CoreLocalDatasourceImpl({
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
  