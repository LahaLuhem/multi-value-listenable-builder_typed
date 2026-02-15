// Need dynamic for handling multiple types.
// ignore_for_file: avoid-dynamic

import 'package:flutter/foundation.dart' show Listenable, ValueListenable, listEquals;
import 'package:flutter/material.dart';

/// This widget listens to multiple [ValueListenable]s and
/// calls given builder function if any one of them changes.
class MultiValueListenableBuilder extends StatefulWidget {
  /// List of [ValueListenable]s to listen to.
  final List<ValueListenable<dynamic>> valueListenables;

  /// The builder function to be called when value of any of the [ValueListenable] changes.
  /// The order of values list will be same as [valueListenables] list.
  final Widget Function(BuildContext, List<dynamic>, Widget?) builder;

  /// An optional child widget which will be available as child parameter in [builder].
  final Widget? child;

  /// Creates a [MultiValueListenableBuilder] widget.
  const MultiValueListenableBuilder({
    required this.valueListenables,
    required this.builder,
    super.key,
    this.child,
  });

  @override
  State<MultiValueListenableBuilder> createState() => _MultiValueListenableBuilderState();
}

class _MultiValueListenableBuilderState extends State<MultiValueListenableBuilder> {
  late Listenable _mergedListenable;

  @override
  void initState() {
    super.initState();

    assert(widget.valueListenables.isNotEmpty, 'valueListenables must not be empty');
    _mergedListenable = Listenable.merge(widget.valueListenables);
  }

  @override
  void didUpdateWidget(covariant MultiValueListenableBuilder oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (listEquals(oldWidget.valueListenables, widget.valueListenables)) return;

    _mergedListenable = Listenable.merge(widget.valueListenables);
  }

  @override
  Widget build(BuildContext context) => ListenableBuilder(
    listenable: _mergedListenable,
    builder: (context, child) =>
        widget.builder(context, [for (final v in widget.valueListenables) v.value], child),
    child: widget.child,
  );
}
