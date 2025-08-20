import 'dart:async';

import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';

import 'locate.config.dart';

final GetIt locate = GetIt.instance;

@InjectableInit(asExtension: false)
FutureOr<GetIt> setupLocator() async => await init(locate);
  