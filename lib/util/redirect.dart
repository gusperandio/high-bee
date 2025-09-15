import 'package:url_launcher/url_launcher.dart';

Future<void> redirect(String link, LaunchMode launch) async {
  final url = Uri.parse(link);

  if (await canLaunchUrl(url)) {
    await launchUrl(url, mode: launch);
  } else {
    throw "Erro ao redirecionar para o site!";
  }
}

void enviarEmail(String sendTo, String subject) async {
  final Uri emailUri = Uri(
    scheme: 'mailto',
    path: sendTo,
    queryParameters: {'subject': subject},
  );
  if (await canLaunchUrl(emailUri)) {
    await launchUrl(emailUri);
  }
}
