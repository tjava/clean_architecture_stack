import 'package:dio/dio.dart';
import 'package:retrofit/retrofit.dart' as retrofit;

part 'api_service.g.dart';

@retrofit.RestApi(baseUrl: baseUrl)
abstract class ApiService {
  static Future<ApiService> getInstance() async {
    return ApiService(Dio());
  }

  factory ApiService(Dio dio) = _ApiService;

  @retrofit.POST(registerEndpoint)
  Future<void> post({
    @retrofit.Body() required Map<String, dynamic> params,
  });

  @retrofit.GET(homeEndpoint)
  Future<String> getProfile({
    @retrofit.Header('Authorization') required String token,
  });
}
  