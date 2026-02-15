import 'package:flutter/foundation.dart' show Listenable, ValueListenable;
import 'package:flutter/material.dart';

/// A widget that listens to two [ValueListenable]s and rebuilds when either changes.
///
/// The [builder] receives the current values of both listenables.
/// An optional [child] can be used to optimize rebuilds for static subtrees.
class DualValueListenableBuilder<A, B> extends StatefulWidget {
  final ValueListenable<A> firstListenable;
  final ValueListenable<B> secondListenable;
  final Widget Function(BuildContext, A, B, Widget?) builder;
  final Widget? child;

  const DualValueListenableBuilder({
    required this.firstListenable,
    required this.secondListenable,
    required this.builder,
    super.key,
    this.child,
  });

  @override
  State<DualValueListenableBuilder<A, B>> createState() => _DualValueListenableBuilderState<A, B>();
}

class _DualValueListenableBuilderState<A, B> extends State<DualValueListenableBuilder<A, B>> {
  late Listenable _mergedListenable;

  @override
  void initState() {
    super.initState();

    _mergedListenable = Listenable.merge([widget.firstListenable, widget.secondListenable]);
  }

  @override
  void didUpdateWidget(covariant DualValueListenableBuilder<A, B> oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.firstListenable == widget.firstListenable &&
        oldWidget.secondListenable == widget.secondListenable) {
      return;
    }

    _mergedListenable = Listenable.merge([widget.firstListenable, widget.secondListenable]);
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _mergedListenable,
    builder: (context, child) =>
        widget.builder(context, widget.firstListenable.value, widget.secondListenable.value, child),
    child: widget.child,
  );
}
