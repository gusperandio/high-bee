import 'dart:math';

class AvatarUtil {
  final List<String> _names = [
    'profile1',
    'profile2',
    'profile3',
    'profile4',
    'profile5',
  ];

  String getRandomName() {
    final random = Random();
    return _names[random.nextInt(_names.length)];
  }

  String getAvatarAsset() {
    String name = getRandomName();
    return 'assets/lottie/$name.gif';
  }
}
