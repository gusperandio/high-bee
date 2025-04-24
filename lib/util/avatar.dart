import 'dart:math';

class AvatarUtil {
  final List<String> _names = [
    'Amaya',
    'Sophia',
    'Mason',
    'Adrian',
    'Jack',
    'Alexander',
    'Avery',
    'Kingston',
    'Jade',
    'Nolan',
    'Destiny',
    'Robert',
    'Oliver',
    'Leah',
    'Sara',
    'Aiden',
    'Riley',
    'Caleb',
  ];

  String getRandomName() {
    final random = Random();
    return _names[random.nextInt(_names.length)];
  }

  String getAvatarUrl() {
    String name = getRandomName();
    return 'https://api.dicebear.com/9.x/thumbs/svg?seed=$name';
  }
}
