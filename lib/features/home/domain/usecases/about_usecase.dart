import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';

@LazySingleton()
classAboutUsecase extends UsecaseWithoutParams<void> {
  final HomeRepository homeRepository;

  AboutUsecase({
    required this.homeRepository,
  });

  @override
  Future<Either<Failure, void>> call() {
    return homeRepository.firstMethod();
  }
}
  