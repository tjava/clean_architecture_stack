import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
class ContactUsecase extends UsecaseWithParams<void, String> {
  final HomeRepository homeRepository;

  ContactUsecase({
    required this.homeRepository,
  });

  @override
  Future<Either<Failure, void>> call(String params) {
    return homeRepository.firstMethod(params);
  }
}
  