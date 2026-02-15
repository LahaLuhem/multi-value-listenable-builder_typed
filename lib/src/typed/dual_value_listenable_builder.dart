import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class DualValueListenableBuilder<A, B> extends StatelessWidget {
  final ValueListenable<A> firstListenable;
  final ValueListenable<B> secondListenable;
  final Widget Function(BuildContext, A, B, Widget?) builder;

  final Widget? child;

  const DualValueListenableBuilder({
    required this.firstListenable,
    required this.secondListenable,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: Listenable.merge([firstListenable, secondListenable]),
    builder: (context, child) =>
        builder(context, firstListenable.value, secondListenable.value, child),
    child: child,
  );
}
