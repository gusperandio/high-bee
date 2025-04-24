import 'package:flutter/material.dart';
import 'package:high_bee/components/widgets/buttons/button.dart';
import 'package:high_bee/providers/authentication_state.dart';
import 'package:high_bee/util/provider.dart';

class ProfilePage extends StatelessWidget {
  static const routeName = 'profile';
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final authState = MSProvider.get<AuthenticationState>(context);
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            const CircleAvatar(
              radius: 50,
              backgroundImage: NetworkImage(
                'https://i.pravatar.cc/554',
              ),
            ),
            const SizedBox(height: 16),
            const Text(
              'João Silva',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const Text(
              'joao.silva@email.com',
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 24),

            // STICKERS
            const Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.emoji_events, color: Colors.amber, size: 32),
                SizedBox(width: 16),
                Icon(Icons.star, color: Colors.orange, size: 32),
                SizedBox(width: 16),
                Icon(Icons.verified, color: Colors.blue, size: 32),
              ],
            ),
            const SizedBox(height: 32),

            // REGRAS
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                '📌 Regras',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(height: 8),
            const Text('• Seja respeitoso com os outros.'),
            const Text('• Não compartilhe conteúdo ofensivo.'),
            const Text('• Siga os termos de uso.'),
            const SizedBox(height: 32),

            Button.black(
              onPressed: () {
                authState.logout();
              },
              title: "Sair",
            )
          ],
        ));
  }
}
