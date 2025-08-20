import 'dart:io';
import 'package:args/args.dart';
import '../default_files_contents/data_file_contents.dart';

class UsecaseGenerator {
  void run(List<String> args) {
    final parser =
        ArgParser()
          ..addOption('feature', abbr: 'f', help: 'Feature name (e.g. auth)')
          ..addOption('name', abbr: 'n', help: 'Usecase name (e.g. login)')
          ..addFlag('withParam', abbr: 'p', negatable: false, help: 'Usecase with param');

    final results = parser.parse(args);
    final featureName = results['feature'];
    final usecaseName = results['name'];
    final usecaseWithParam = results['withParam'] as bool;

    if (featureName == null || usecaseName == null) {
      print('❌ Please provide both feature (-f) and usecase name (-n)');
      print('Example: clean_architecture_stack usecase -f auth -n login');
      return;
    }

    final usecaseFile = File(
      'lib/features/$featureName/domain/usecases/${usecaseName}_usecase.dart',
    );

    if (!usecaseFile.existsSync()) {
      usecaseFile.createSync(recursive: true);
      if (usecaseWithParam == false) {
        usecaseFile.writeAsStringSync(usecaseWithoutParams(usecaseName, featureName));
      } else {
        usecaseFile.writeAsStringSync(usecaseWithParams(usecaseName, featureName));
      }
      print('✅ Usecase "$usecaseName" added to feature "$featureName"');
    } else {
      print('⚠️ Usecase already exists: ${usecaseFile.path}');
    }
  }
}
