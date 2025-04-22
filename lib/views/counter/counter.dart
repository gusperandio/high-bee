// view/counter_view.dart
import 'package:flutter/material.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/viewmodel/counter.dart';
import 'package:provider/provider.dart';

class CounterView extends StatelessWidget {
  static const routeName = 'counter';

  const CounterView({super.key});
  @override
  Widget build(BuildContext context) {
    return AppContainer(
      appBar: AppBar(title: Text("MVVM Counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<CounterViewModel>(
              // Observa o ViewModel
              builder: (context, viewModel, child) {
                return Text(
                  'Counter: ${viewModel.count}',
                  style: TextStyle(fontSize: 30),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<CounterViewModel>().incrementCounter();
              },
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}
