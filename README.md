# MultiValueListenableBuilder

A widget to listen to
multiple [ValueListenable](https://api.flutter.dev/flutter/widgets/ValueListenableBuilder-class.html)
s in Flutter.

![pub](https://img.shields.io/pub/v/multi_value_listenable_builder?logo=multivaluelistenablebuilder)

## Reason for the fork

This is fork-and-rewrap of the the
original [multi_value_listenable_builder](https://github.com/ufrshubham/multi-value-listenable-builder)
package. This aims to provide type-safety, instead of using dynamic listneables, that need
type-casting at the time of builder definition.

### Available type-safe variants:

1. [DualValueListenableBuilder](lib/src/typed/dual_value_listenable_builder.dart)
2. [TripleValueListenableBuilder](lib/src/typed/triple_value_listenable_builder.dart)

## Usage

1. Add the multi_value_listenable_builder as a dependency in your project.

2. Import `package:multi_value_listenable_builder_typed/multi_value_listenable_builder_typed.dart`
   in required
   files.

3. Use the typed variants for typed callbacks.

4. Use `MultiValueListenableBuilder`, for more listenable, just like any other widget.

```dart
import 'package:multi_value_listenable_builder_typed/multi_value_listenable_builder_typed.dart';

MultiValueListenableBuilder
(
// Add all ValueListenables here.
valueListenables: [
listenable0,
listenable1,
listenable2,
    .
    .
listenableN
],
builder: (context, values, child) {
// Get the updated value of each listenable
// in values list.
return YourWidget(
values.elementAt(0),
values.elementAt(1),
values.elementAt(2),
    .
    .
values.elementAt(N),
child: child // Optional child.
);
},
child
:
YourOptionalChildWidget
(
)
,
)
```

A detailed and working example can be
found [here](https://github.com/ufrshubham/multi-value-listenable-builder/tree/main/example/).

