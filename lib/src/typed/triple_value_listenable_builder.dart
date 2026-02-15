import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

class TripleValueListenableBuilder<A, B, C> extends StatefulWidget {
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
  State<TripleValueListenableBuilder<A, B, C>> createState() =>
      _TripleValueListenableBuilderState<A, B, C>();
}

class _TripleValueListenableBuilderState<A, B, C>
    extends State<TripleValueListenableBuilder<A, B, C>> {
  late Listenable _mergedListenable;

  @override
  void initState() {
    super.initState();

    _mergedListenable = Listenable.merge([
      widget.firstListenable,
      widget.secondListenable,
      widget.thirdListenable,
    ]);
  }

  @override
  void didUpdateWidget(covariant TripleValueListenableBuilder<A, B, C> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.firstListenable == widget.firstListenable &&
        oldWidget.secondListenable == widget.secondListenable &&
        oldWidget.thirdListenable == widget.thirdListenable) {
      return;
    }

    _mergedListenable = Listenable.merge([
      widget.firstListenable,
      widget.secondListenable,
      widget.thirdListenable,
    ]);
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _mergedListenable,
    builder: (context, child) => widget.builder(
      context,
      widget.firstListenable.value,
      widget.secondListenable.value,
      widget.thirdListenable.value,
      child,
    ),
    child: widget.child,
  );
}
