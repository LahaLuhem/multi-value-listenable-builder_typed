import 'package:flutter/material.dart';
import 'package:multi_value_listenable_builder_typed/multi_value_listenable_builder_typed.dart';

void main() {
  runApp(
    MaterialApp(
      title: 'Multi-ValueListenableBuilder Demo',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const Demo(),
    ),
  );
}

class Demo extends StatefulWidget {
  const Demo({super.key});

  @override
  State<Demo> createState() => _DemoState();
}

class _DemoState extends State<Demo> {
  static const _labels = ['Alpha', 'Red', 'Green', 'Blue'];
  final List<ValueNotifier<int>> _argb = [
    ValueNotifier(255), // Alpha
    ValueNotifier(255), // Red
    ValueNotifier(255), // Green
    ValueNotifier(255), // Blue
  ];

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text('Multi-ValueListenableBuilder Demo')),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 50),
            child: MultiValueListenableBuilder(
              valueListenables: _argb,
              builder: (context, values, child) => Container(
                decoration: ShapeDecoration(
                  shadows: const [BoxShadow(blurRadius: 5)],
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                  color: Color.fromARGB(
                    values.first as int, // Alpha
                    values[1] as int, // Red
                    values[2] as int, // Green
                    values[3] as int, // Blue
                  ),
                ),
                height: 200,
                width: 200,
              ),
            ),
          ),
          Column(
            children: [0, 1, 2, 3]
                .map(
                  (index) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(_labels.elementAt(index), style: const TextStyle(fontSize: 20)),
                      ValueListenableBuilder<int>(
                        valueListenable: _argb.elementAt(index),
                        builder: (context, value, child) => Slider(
                          value: value.toDouble(),
                          max: 255,
                          onChanged: (newValue) {
                            _argb[index].value = newValue.toInt();
                          },
                        ),
                      ),
                    ],
                  ),
                )
                .toList(),
          ),
        ],
      ),
    ),
  );
}
