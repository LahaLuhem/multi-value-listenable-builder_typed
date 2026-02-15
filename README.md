# MultiValueListenableBuilder

[![pub package](https://img.shields.io/pub/v/multi_value_listenable_builder_typed.svg?logo=dart&logoColor=white)](https://pub.dev/packages/multi_value_listenable_builder_typed)
[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)

A Flutter widget that listens to multiple [`ValueListenable`](https://api.flutter.dev/flutter/foundation/ValueListenable-class.html)s and rebuilds when any of them changes. This package provides both a flexible dynamic version and type‑safe variants for 2 or 3 listenables.

---

## Features

- ✅ Listen to any number of `ValueListenable`s with the generic `MultiValueListenableBuilder`
- ✅ Type‑safe builders for two (`DualValueListenableBuilder<A, B>`) and three (`TripleValueListenableBuilder<A, B, C>`) listenables
- ✅ Optional `child` parameter to optimise rebuilds for static subtrees
- ✅ Built on Flutter’s own `ListenableBuilder` for efficiency
- ✅ Zero dependencies beyond Flutter

## Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  multi_value_listenable_builder_typed: ^1.0.0   # replace with latest version
```
Then run `flutter pub get`.

## Usage
Import the package:

```dart
import 'package:multi_value_listenable_builder_typed/multi_value_listenable_builder_typed.dart';
```

### Type-safe variants

#### `DualValueListenableBuilder<A, B>`
```dart
final ValueNotifier<String> nameNotifier = ValueNotifier('Alice');
final ValueNotifier<int> ageNotifier = ValueNotifier(30);

DualValueListenableBuilder<String, int>(
  firstListenable: nameNotifier,
  secondListenable: ageNotifier,
  builder: (context, name, age, _) => Text('$name is $age years old'),
)
```

#### `TripleValueListenableBuilder<A, B, C>`
```dart
final ValueNotifier<String> nameNotifier = ValueNotifier('Alice');
final ValueNotifier<int> ageNotifier = ValueNotifier(30);
final ValueNotifier<bool> activeNotifier = ValueNotifier(true);

TripleValueListenableBuilder<String, int, bool>(
  firstListenable: nameNotifier,
  secondListenable: ageNotifier,
  thirdListenable: activeNotifier,
  builder: (context, name, age, active, _) => Text('$name is $age years old and ${active ? 'active' : 'inactive'}'),
)
```

### Flexible dynamic variant (any number of listenables)
`MultiValueListenableBuilder` takes a `List<ValueListenable<dynamic>>` and passes a `List<dynamic>` to the builder.
The order of values matches the order of the provided listenables.
```dart
MultiValueListenableBuilder(
  valueListenables: [
    nameNotifier,
    ageNotifier,
    activeNotifier,
    // ... any number of listenables
  ],
  builder: (context, values, child) {
    final name = values[0] as String;
    final age = values[1] as int;
    final active = values[2] as bool;
    return Text('$name, $age, active: $active');
  },
  child: SomeStaticWidget(), // optional – won’t rebuild on changes
)
```
> Note: Because `values` is a `List<dynamic>`, you need to cast each element to its expected type. 
> For a small, fixed number of listenables the typed variants are cleaner and safer.
 
## Motivation
The original [`multi_value_listenable_builder`](https://pub.dev/packages/multi_value_listenable_builder) package uses a `List<ValueListenable<dynamic>>` and passes a `List<dynamic>` to the builder.
While this works for any number of listenables, it sacrifices type safety – you must manually cast values inside the builder.

This fork adds **type‑safe variants** for 2 and 3 listenables, keeping the original dynamic version for cases where the number of listenables is variable or large.

## Optimising rebuilds with `child`
All three widgets accept an optional `child` parameter.
This child is passed to the builder and can be used for parts of the widget tree that do not depend on the listenable values.
The child is built only once and reused across rebuilds, improving performance.
```dart
MultiValueListenableBuilder(
  valueListenables: [nameNotifier, ageNotifier],
  child: Icon(Icons.person),             // never rebuilt
  builder: (context, values, child) => Column(
      children: [
        Text('Name: ${values.first}'),   // changes
        Text('Age: ${values[1]}'),       // changes
        ?child,        // static part
      ],
    ),
)
```

## Examples
A complete working example can be found in the [example](example/) folder of the original repository.

## Contributing
Issues and pull requests are welcome!<br>
Please ensure that any changes are covered by tests and that the example app still runs.

## License
This package is licensed under the [MIT License](LICENSE).
