String localDataSource(String name) {
  return '''
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class ${_capitalize(name)}LocalDatasource {
  Future<void> firstMethod(String data);
}

@LazySingleton(as: ${_capitalize(name)}LocalDatasource)
class ${_capitalize(name)}LocalDatasourceImpl implements ${_capitalize(name)}LocalDatasource {
  final SharedPreferences sharedPreferences;

  ${_capitalize(name)}LocalDatasourceImpl({
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
  ''';
}

String remoteDataSource(String name) {
  return '''
import 'package:injectable/injectable.dart';

abstract class ${_capitalize(name)}RemoteDatasource {
  Future<void> firstMethod(String data);
}

@LazySingleton(as: ${_capitalize(name)}RemoteDatasource)
class ${_capitalize(name)}RemoteDatasourceImpl implements ${_capitalize(name)}RemoteDatasource {
  final ApiService apiService;

  ${_capitalize(name)}RemoteDatasourceImpl({
    required this.apiService,
  });

  @override
  Future<void> firstMethod(String data) async {
    return await apiService.firstMethod('kAccessToken', 'accessToken');
  }
}
  ''';
}

String model(String name) {
  return '''
class ${_capitalize(name)}Model extends ${_capitalize(name)}Entity {
  const ${_capitalize(name)}Model({required super.id});

  factory ${_capitalize(name)}Model.fromJson(Map<String, dynamic> json) => ${_capitalize(name)}Model(
        id: json["id"],
      );
}
  ''';
}

String repositoryImpl(String name) {
  return '''
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: ${_capitalize(name)}Repository)
class ${_capitalize(name)}RepositoryImpl implements ${_capitalize(name)}Repository {
  final ${_capitalize(name)}RemoteDatasource ${_normalize(name)}RemoteDatasource;
  final ${_capitalize(name)}LocalDatasource ${_normalize(name)}LocalDataSource;
  const ${_capitalize(name)}RepositoryImpl({
    required this.${_normalize(name)}RemoteDatasource,
    required this.${_normalize(name)}LocalDataSource,
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
  ''';
}

String repository(String name) {
  return '''
import 'package:dartz/dartz.dart';

abstract class ${_capitalize(name)}Repository {
  Future<Either<Failure, void>> firstMethod(String data);
}
  ''';
}

String entity(String name) {
  return '''
import 'package:equatable/equatable.dart';

class ${_capitalize(name)}Entity extends Equatable {
}
  ''';
}

String constant() {
  return '''
const String lblHello = 'Hello';
  ''';
}

String usecaseWithParams(String name, String repo) {
  return '''
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ${_capitalize(name)}Usecase extends UsecaseWithParams<void, String> {
  final ${_capitalize(repo)}Repository ${_normalize(repo)}Repository;

  ${_capitalize(name)}Usecase({
    required this.${_normalize(repo)}Repository,
  });

  @override
  Future<Either<Failure, void>> call(String params) {
    return ${_normalize(repo)}Repository.firstMethod(params);
  }
}
  ''';
}

String usecaseWithoutParams(String name, String repo) {
  return '''
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class${_capitalize(name)}Usecase extends UsecaseWithoutParams<void> {
  final ${_capitalize(repo)}Repository ${_normalize(repo)}Repository;

  ${_capitalize(name)}Usecase({
    required this.${_normalize(repo)}Repository,
  });

  @override
  Future<Either<Failure, void>> call() {
    return ${_normalize(repo)}Repository.firstMethod();
  }
}
  ''';
}

String page(String name) {
  return '''
import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';

@RoutePage<dynamic>()
class ${_capitalize(name)}Page extends StatelessWidget {
  const ${_capitalize(name)}Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('${_capitalize(name)}')),
      body: const Center(child: Text('Hello from $name')),
    );
  }
}
  ''';
}

String apiConstant() {
  return '''
const String baseUrl = 'https://example.com';
  ''';
}

String assetsConstant() {
  return '''
const String logo = 'assets/images/logo.png';
  ''';
}

String colorsConstant() {
  return '''
import 'package:flutter/material.dart';

const Color black = Color(0xFF111827);
  ''';
}

String stringsConstant() {
  return '''
const String kGenericError = 'Something went wrong.';
  ''';
}

String exceptions() {
  return '''
import 'package:equatable/equatable.dart';

class ServerException extends Equatable implements Exception {
  final String message;
  final String statusCode;
  const ServerException({
    required this.message,
    required this.statusCode,
  });

  @override
  List<Object> get props => [message, statusCode];
}

class CacheException extends Equatable implements Exception {
  final String message;
  final int statusCode;
  const CacheException({
    required this.message,
    this.statusCode = 500,
  });

  @override
  List<Object> get props => [message, statusCode];
}

  ''';
}

String failures() {
  return '''
import 'package:equatable/equatable.dart';

abstract class Failure extends Equatable {
  final String? message;
  final dynamic statusCode;
  const Failure({
    this.message,
    this.statusCode,
  });
}

class NoInternetConnectionFailure extends Failure {
  @override
  List<Object> get props => <Object>[];
}

class PermissionDeniedFailure extends Failure {
  @override
  List<Object> get props => <Object>[];
}

class ServerFailure extends Failure {
  const ServerFailure({required super.message, required super.statusCode});

  @override
  List<Object> get props => <Object>[message!, statusCode!];
}

class CacheFailure extends Failure {
  const CacheFailure({required super.message});

  @override
  List<Object> get props => <Object>[message!];
}

class CancelFailure extends Failure {
  const CancelFailure({required super.message});

  @override
  List<Object> get props => <Object>[message!];
}

class GenericFailure extends Failure {
  const GenericFailure({required super.message});

  @override
  List<Object?> get props => <Object?>[message];
}
  ''';
}

String apiService() {
  return '''
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
  ''';
}

String thirdPartyServicesModule() {
  return '''
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

@Injectable()
@module
abstract class ThirdPartyServicesModule {
  @LazySingleton()
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @LazySingleton()
  @preResolve
  Future<ApiService> get apiService => ApiService.getInstance();
}
  ''';
}

String coreUsecase() {
  return '''
import 'package:dartz/dartz.dart';

abstract class UsecaseWithParams<Type, Params> {
  Future<Either<Failure?, Type>>? call(Params params);
}

abstract class UsecaseWithoutParams<Type> {
  Future<Either<Failure?, Type>>? call();
}
  ''';
}

String globalKeys() {
  return '''
import 'package:flutter/material.dart';

final GlobalKey<ScaffoldMessengerState> scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  ''';
}

String snackBar() {
  return '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SnackBar showSnackBar(
    {required BuildContext context, required String message, Color color = black}) {
  return SnackBar(
    content: GenericRichText(
      text: message,
      size: 12.sp,
      color: white,
      textAlign: TextAlign.start,
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 3),
    showCloseIcon: true,
  );
}
  ''';
}

String genericText() {
  return '''
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenericText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextOverflow? overflow;

  const GenericText({
    super.key,
    required this.text,
    this.size,
    this.color,
    this.weight,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 16.sp,
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.normal,
      ),
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }
}
  ''';
}

String genericRichText() {
  return '''
import 'package:flutter/material.dart';

class GenericRichText extends StatelessWidget {
  final String text;
  final double? size;
  final double? lineHeight;
  final int? maxLines;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? textAlign;

  const GenericRichText({
    super.key,
    required this.text,
    this.size,
    this.lineHeight,
    this.maxLines,
    this.color,
    this.weight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines ?? 100,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: text,
        style: TextStyle(
          height: lineHeight,
          color: color ?? grey,
          fontSize: size ?? 16,
          fontWeight: weight ?? FontWeight.w400,
        ),
      ),
    );
  }
}
  ''';
}

String locate() {
  return '''
import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'locate.config.dart';

final GetIt locate = GetIt.instance;

@InjectableInit(asExtension: false)
FutureOr<GetIt> setupLocator() async => await init(locate);
  ''';
}

String router() {
  return '''
import 'package:auto_route/auto_route.dart';

import 'router.gr.dart';

@AutoRouterConfig(
  replaceInRouteName: 'Page,Route',
)
class AppRouter extends RootStackRouter {
  @override
  RouteType get defaultRouteType => const RouteType.material();

  @override
  final List<AutoRoute> routes = [
    AutoRoute(
      page: LayoutRoute.page,
      path: '/public',
      initial: true,
    ),
    AutoRoute(
      page: HomeRoute.page,
      path: '/home',
      guards: [AuthGuard()],
    ),
  ];
}
  ''';
}

String authGuard() {
  return '''
import 'package:auto_route/auto_route.dart';
import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@lazySingleton
class AuthGuard extends AutoRouteGuard {
  final CoreRepository coreRepository = locate<CoreRepository>();
  final AuthRepository authRepository = locate<AuthRepository>();

  @override
  Future<void> onNavigation(NavigationResolver resolver, StackRouter router) async {
    final Either<Failure, String?> result = await coreRepository.getAccessToken();
    result.fold(
      (Failure failure) async {
        router.replaceAll([const LoginRoute()]);
      },
      (String? value) {
        if (value != '' && value != null) {
          resolver.next(true);
        } else {
          router.replaceAll([const LoginRoute()]);
        }
      },
    );
  }
}
  ''';
}

String _capitalize(String text) => text.isEmpty ? text : text[0].toUpperCase() + text.substring(1);
String _normalize(String text) => text.isEmpty ? text : text.toLowerCase();
