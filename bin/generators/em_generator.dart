import 'dart:io';
import 'package:args/args.dart';
import '../default_files_contents/data_file_contents.dart';

class EmGenerator {
  void run(List<String> args) {
    final parser =
        ArgParser()
          ..addOption('feature', abbr: 'f', help: 'Feature name (e.g. auth)')
          ..addOption('name', abbr: 'n', help: 'page name (e.g. login)');

    final results = parser.parse(args);
    final featureName = results['feature'];
    final emName = results['name'];

    if (featureName == null || emName == null) {
      print('❌ Please provide both feature (-f) and em name (-n)');
      print('Example: clean_architecture_stack page -f auth -n login');
      return;
    }

    final entityFile = File('lib/features/$featureName/domain/entities/${emName}_entity.dart');
    final modelFile = File('lib/features/$featureName/data/models/${emName}_model.dart');

    if (!entityFile.existsSync()) {
      entityFile.createSync(recursive: true);
      entityFile.writeAsStringSync(entity(emName));
      print('✅ entity "$emName" added to feature "$featureName"');
    } else {
      print('⚠️ entity already exists: ${entityFile.path}');
    }

    if (!modelFile.existsSync()) {
      modelFile.createSync(recursive: true);
      modelFile.writeAsStringSync(model(emName));
      print('✅ model "$emName" added to feature "$featureName"');
    } else {
      print('⚠️ model already exists: ${modelFile.path}');
    }
  }
}
