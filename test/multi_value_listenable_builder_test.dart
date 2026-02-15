import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:multi_value_listenable_builder_typed/src/multi_value_listenable_builder.dart';

List<ValueNotifier<int>> listenables = [ValueNotifier(1), ValueNotifier(2)];

class MyWidget extends StatelessWidget {
  const MyWidget({super.key});

  @override
  Widget build(BuildContext context) => MaterialApp(
    home: Scaffold(
      body: MultiValueListenableBuilder(
        valueListenables: listenables,
        builder: (context, values, child) =>
            Column(children: values.map((val) => Text('$val')).toList()),
      ),
    ),
  );
}

void main() {
  testWidgets('Test initial vs updated values', (tester) async {
    await tester.pumpWidget(const MyWidget());

    final findOne = find.text('1');
    final findTwo = find.text('2');

    expect(findOne, findsOneWidget);
    expect(findTwo, findsOneWidget);

    listenables[0].value = 10;
    listenables[1].value = 20;

    await tester.pump();

    final findTen = find.text('10');
    final findTwenty = find.text('20');

    expect(findTen, findsOneWidget);
    expect(findTwenty, findsOneWidget);
  });
}
