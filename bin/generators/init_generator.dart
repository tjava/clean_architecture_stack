import 'dart:io';
import 'package:args/args.dart';
import '../default_files_contents/data_file_contents.dart';

class InitGenerator {
  void run(List<String> args) {
    final parser = ArgParser()..addOption('name', abbr: 'n', help: 'Project name (e.g. todo)');

    final results = parser.parse(args);
    final projectName = results['name'];

    if (projectName == null) {
      print('❌ Please provide a project name: -n <name>');
      return;
    }

    final baseDir = Directory('lib');

    _createDir('${baseDir.path}/core/constants');
    _createDir('${baseDir.path}/core/cubits');
    _createDir('${baseDir.path}/core/data/datasources');
    _createDir('${baseDir.path}/core/data/models');
    _createDir('${baseDir.path}/core/data/repositories');
    _createDir('${baseDir.path}/core/domain/entities');
    _createDir('${baseDir.path}/core/domain/repositories');
    _createDir('${baseDir.path}/core/domain/usecases');
    _createDir('${baseDir.path}/core/errors');
    _createDir('${baseDir.path}/core/services');
    _createDir('${baseDir.path}/core/usecase');
    _createDir('${baseDir.path}/core/utils');
    _createDir('${baseDir.path}/core/widgets');
    _createDir('${baseDir.path}/features');
    _createDir('${baseDir.path}/locator');
    _createDir('${baseDir.path}/navigator');

    // default files
    _createFile('${baseDir.path}/core/constants/api_constant.dart', apiConstant());
    _createFile('${baseDir.path}/core/constants/assets_constant.dart', assetsConstant());
    _createFile('${baseDir.path}/core/constants/colors_constant.dart', colorsConstant());
    _createFile('${baseDir.path}/core/constants/strings_constant.dart', stringsConstant());

    _createFile(
      '${baseDir.path}/core/data/datasources/core_local_datasource.dart',
      localDataSource('core'),
    );
    _createFile(
      '${baseDir.path}/core/data/datasources/core_remote_datasource.dart',
      remoteDataSource('core'),
    );
    _createFile(
      '${baseDir.path}/core/data/repositories/core_repository_impl.dart',
      repositoryImpl('core'),
    );
    _createFile(
      '${baseDir.path}/core/domain/repositories/core_repository.dart',
      repository('core'),
    );

    _createFile('${baseDir.path}/core/errors/exceptions.dart', exceptions());
    _createFile('${baseDir.path}/core/errors/failures.dart', failures());

    _createFile('${baseDir.path}/core/services/api_service.dart', apiService());
    _createFile(
      '${baseDir.path}/core/services/third_party_services_module.dart',
      thirdPartyServicesModule(),
    );

    _createFile('${baseDir.path}/core/usecase/usecase.dart', coreUsecase());

    _createFile('${baseDir.path}/core/utils/global_keys.dart', globalKeys());
    _createFile('${baseDir.path}/core/utils/snack_bar.dart', snackBar());

    _createFile('${baseDir.path}/core/widgets/generic_text.dart', genericText());
    _createFile('${baseDir.path}/core/widgets/generic_rich_text.dart', genericRichText());

    _createFile('${baseDir.path}/locator/locate.dart', locate());

    _createFile('${baseDir.path}/navigator/router.dart', router());
    _createFile('${baseDir.path}/navigator/guards/auth_guard.dart', authGuard());

    _createFile('${baseDir.path}/${projectName}_constants.dart', constant());

    print('✅ Project "$projectName" initialized successfully!');
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
