// view/counter_view.dart
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:high_bee/components/app_container.dart';
import 'package:high_bee/viewmodel/counter.dart';
import 'package:provider/provider.dart';

class CounterView extends StatefulWidget {
  static const routeName = 'counter';

  const CounterView({super.key});

  @override
  State<CounterView> createState() => _CounterViewState();
}

class _CounterViewState extends State<CounterView> {
  String myNum = '0';
  final DatabaseReference _testRef = FirebaseDatabase.instance.ref().child(
    'count',
  );
  @override
  Widget build(BuildContext context) {
    _testRef.onValue.listen((event) {
      setState(() {
        myNum = event.snapshot.value.toString();
      });
    });
    return AppContainer(
      // appBar: AppBar(title: Text("MVVM Counter")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Consumer<CounterViewModel>(
              // Observa o ViewModel
              builder: (context, viewModel, child) {
                return Text('Counter: $myNum', style: TextStyle(fontSize: 30));
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                context.read<CounterViewModel>().incrementCounter();
              },
              child: Text('Increment'),
            ),
            ElevatedButton(
              onPressed: () {
                context.read<CounterViewModel>().removeCount();
              },
              child: Text('Zerar'),
            ),
          ],
        ),
      ),
    );
  }
}
