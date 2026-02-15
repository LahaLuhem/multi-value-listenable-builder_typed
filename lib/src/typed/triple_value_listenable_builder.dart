import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';

/// A widget that listens to three [ValueListenable]s and rebuilds when any of them changes.
///
/// The [builder] receives the current values of both listenables.
/// An optional [child] can be used to optimize rebuilds for static subtrees.
class TripleValueListenableBuilder<A, B, C> extends StatefulWidget {
  /// The first [ValueListenable] to listen to.
  final ValueListenable<A> firstListenable;

  /// The second [ValueListenable] to listen to.
  final ValueListenable<B> secondListenable;

  /// The third [ValueListenable] to listen to.
  final ValueListenable<C> thirdListenable;

  /// The builder function that builds the widget tree based on the current values of both listenables.
  final Widget Function(BuildContext, A, B, C, Widget?) builder;

  /// An optional child widget that can be used to optimize rebuilds for static subtrees.

  final Widget? child;

  /// Creates a [TripleValueListenableBuilder] widget.
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
