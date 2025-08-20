import 'dart:io';
import 'generators/init_generator.dart';
import 'generators/feature_generator.dart';
import 'generators/usecase_generator.dart';
import 'generators/em_generator.dart';
import 'generators/page_generator.dart';

void main(List<String> args) {
  if (args.isEmpty) {
    print('Usage: clean_architecture_stack <command> [arguments]');
    print('Commands: init, feature, usecase, em, page');
    exit(0);
  }

  final command = args.first;
  final restArgs = args.skip(1).toList();

  switch (command) {
    case 'init':
      InitGenerator().run(restArgs);
      break;
    case 'feature':
      FeatureGenerator().run(restArgs);
      break;
    case 'usecase':
      UsecaseGenerator().run(restArgs);
      break;
    case 'em':
      EmGenerator().run(restArgs);
      break;
    case 'page':
      PageGenerator().run(restArgs);
      break;
    default:
      print('❌ Unknown command: $command');
      print('Commands: feature, repo, usecase, model');
      exit(1);
  }
}
