import 'dart:io';

void main() async {
  stdout.write('Qual o nome da pasta? ');
  String? folderName = stdin.readLineSync();

  if (folderName == null || folderName.trim().isEmpty) {
    print('Nome da pasta inválido.');
    exit(1);
  }

  final basePath = Directory.current.path;
  final targetPath = '$basePath/lib/feature/${folderName.trim()}';

  final foldersToCreate = ['controller', 'model', 'model_state', 'repository', 'service', 'ui'];

  for (var folder in foldersToCreate) {
    final path = Directory('$targetPath/$folder');
    if (!path.existsSync()) {
      path.createSync(recursive: true);
      print('Criado: ${path.path}');
    } else {
      print('Já existe: ${path.path}');
    }

    final readmeFile = File('${path.path}/README.md');
    if (!readmeFile.existsSync()) {
      readmeFile.writeAsStringSync('# ${folder[0].toUpperCase()}${folder.substring(1)}\n\nDescrição da pasta.');
      print('README.md criado em: ${readmeFile.path}');
    } else {
      print('README.md já existe em: ${readmeFile.path}');
    }
  }
}
