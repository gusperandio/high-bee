import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class StrainPage extends StatelessWidget {
  final List<String> fakeItems = List.generate(100, (index) => 'Item #$index');

  StrainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Lista Animada")),
      body: AnimationLimiter(
        child: ListView.builder(
          padding: const EdgeInsets.all(8),
          itemCount: fakeItems.length,
          itemBuilder: (BuildContext context, int index) {
            return AnimationConfiguration.staggeredList(
              position: index,
              duration: const Duration(milliseconds: 675),
              child: SlideAnimation(
                verticalOffset: 50.0,
                child: FadeInAnimation(
                  child: Card(
                    child: ListTile(
                      leading: Icon(Icons.label_important),
                      title: Text(fakeItems[index]),
                      subtitle: Text("Descrição do item ${index + 1}"),
                      trailing: Icon(Icons.chevron_right),
                      onTap: () {
                        // Ação ao clicar
                      },
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
