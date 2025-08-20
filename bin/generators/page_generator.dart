import 'dart:io';
import 'package:args/args.dart';
import '../default_files_contents/data_file_contents.dart';

class PageGenerator {
  void run(List<String> args) {
    final parser =
        ArgParser()
          ..addOption('feature', abbr: 'f', help: 'Feature name (e.g. auth)')
          ..addOption('name', abbr: 'n', help: 'page name (e.g. login)');

    final results = parser.parse(args);
    final featureName = results['feature'];
    final pageName = results['name'];

    if (featureName == null || pageName == null) {
      print('❌ Please provide both feature (-f) and page name (-n)');
      print('Example: clean_architecture_stack page -f auth -n login');
      return;
    }

    final pageFile = File('lib/features/$featureName/presentation/pages/${pageName}_page.dart');

    if (!pageFile.existsSync()) {
      pageFile.createSync(recursive: true);
      pageFile.writeAsStringSync(page(pageName));
      print('✅ page "$pageName" added to feature "$featureName"');
    } else {
      print('⚠️ page already exists: ${pageFile.path}');
    }
  }
}
