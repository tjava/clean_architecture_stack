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
  