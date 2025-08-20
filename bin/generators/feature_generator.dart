import 'dart:io';
import 'package:args/args.dart';
import '../default_files_contents/data_file_contents.dart';

class FeatureGenerator {
  void run(List<String> args) {
    final parser = ArgParser()..addOption('name', abbr: 'n', help: 'Feature name (e.g. auth)');

    final results = parser.parse(args);
    final featureName = results['name'];

    if (featureName == null) {
      print('❌ Please provide a feature name: -n <name>');
      return;
    }

    final baseDir = Directory('lib/features/$featureName');

    _createDir('${baseDir.path}/data/datasources');
    _createDir('${baseDir.path}/data/models');
    _createDir('${baseDir.path}/data/repositories');
    _createDir('${baseDir.path}/domain/entities');
    _createDir('${baseDir.path}/domain/repositories');
    _createDir('${baseDir.path}/domain/usecases');
    _createDir('${baseDir.path}/presentation/cubits');
    _createDir('${baseDir.path}/presentation/widgets');
    _createDir('${baseDir.path}/presentation/pages');

    // default files
    _createFile(
      '${baseDir.path}/data/datasources/${featureName}_local_datasource.dart',
      localDataSource(featureName),
    );
    _createFile(
      '${baseDir.path}/data/datasources/${featureName}_remote_datasource.dart',
      remoteDataSource(featureName),
    );
    _createFile(
      '${baseDir.path}/data/repositories/${featureName}_repository_impl.dart',
      repositoryImpl(featureName),
    );
    _createFile(
      '${baseDir.path}/domain/repositories/${featureName}_repository.dart',
      repository(featureName),
    );
    _createFile('${baseDir.path}/presentation/pages/${featureName}_page.dart', page(featureName));
    _createFile('${baseDir.path}/${featureName}_constants.dart', constant());

    print('✅ Feature "$featureName" generated successfully!');
  }

  void _createDir(String path) {
    final dir = Directory(path);
    if (!dir.existsSync()) {
      dir.createSync(recursive: true);
      print('📂 Created directory: $path');
    }
  }

  void _createFile(String path, String content) {
    final file = File(path);
    if (!file.existsSync()) {
      file.createSync(recursive: true);
      file.writeAsStringSync(content);
      print('📝 Created file: $path');
    }
  }
}
