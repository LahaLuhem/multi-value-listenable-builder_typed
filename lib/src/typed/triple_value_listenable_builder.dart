import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class TripleValueListenableBuilder<A, B, C> extends StatelessWidget {
  final ValueListenable<A> firstListenable;
  final ValueListenable<B> secondListenable;
  final ValueListenable<C> thirdListenable;

  final Widget Function(BuildContext, A, B, C, Widget?) builder;

  final Widget? child;

  const TripleValueListenableBuilder({
    required this.firstListenable,
    required this.secondListenable,
    required this.thirdListenable,
    required this.builder,
    this.child,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: Listenable.merge([
        firstListenable,
        secondListenable,
        thirdListenable,
      ]),
      builder: (context, child) => builder(context, firstListenable.value,
          secondListenable.value, thirdListenable.value, child),
      child: child,
    );
  }
}
