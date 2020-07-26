# Koin.dart

<p align="center"><img src="https://raw.githubusercontent.com/pbissonho/koin.dart/master/logo.svg" height="150" alt="Koin.dart"></p>

<p align="center">
<a href="https://travis-ci.org/pbissonho/koin.dart"><img src="https://travis-ci.org/pbissonho/koin.dart.svg?branch=master" alt="build"></a>
<a href="https://codecov.io/gh/pbissonho/koin.dart"><img src="https://codecov.io/gh/pbissonho/koin.dart/branch/master/graph/badge.svg" alt="codecov"></a>
<a href="https://github.com/pbissonho/koin.dart"><img src="https://img.shields.io/github/stars/pbissonho/koin.dart.svg?style=flat&logo=github&colorB=deeppink&label=stars" alt="Star on Github"></a>
<a href="https://github.com/tenhobi/effective_dart"><img src="https://img.shields.io/badge/style-effective_dart-40c4ff.svg" alt="style: effective dart"></a>

---

A pragmatic lightweight dependency injection framework. This is a port of [Koin](https://github.com/InsertKoinIO/koin) for Dart projects.

Written in pure Dart, using functional resolution only: no proxy, no code generation, no reflection, no Flutter context.

`Koin is a DSL, a light container and a pragmatic API`

| Package                                                                            | Pub                                                                                                    |
| ---------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------ |
| [koin](https://github.com/pbissonho/koin.dart/tree/master/packages/koin)                 | [![pub package](https://img.shields.io/pub/v/koin.svg)](https://pub.dev/packages/koin)                 |
| [koin_test](https://github.com/pbissonho/koin.dart/tree/master/packages/koin_test)       | [![pub package](https://img.shields.io/pub/v/koin_test.svg)](https://pub.dev/packages/koin_test)       |
| [koin_flutter](https://github.com/pbissonho/koin.dart/tree/master/packages/koin_flutter) | [![pub package](https://img.shields.io/pub/v/koin_flutter.svg)](https://pub.dev/packages/koin_flutter) |
| [koin_bloc](https://github.com/pbissonho/koin.dart/tree/master/packages/koin_bloc) | [![pub package](https://img.shields.io/pub/v/koin_bloc.svg)](https://pub.dev/packages/koin_bloc) |
| [koin_devtools](https://github.com/pbissonho/koin.dart/tree/master/packages/koin_devtools) | [![pub package](https://img.shields.io/pub/v/koin_devtools.svg)](https://pub.dev/packages/koin_devtools) |


## Documentation 🚒

* [Setup](http://koindart.dev/docs/setup)
* [Koin in 5 minutes](http://koindart.dev/docs/start/quickstart/dart)
* [Getting Started](http://koindart.dev/docs/start/getting-started/starting-koin)
* [Documentation References](http://koindart.dev/docs/reference/koin-core/definitions)


# Setup

## Add dependency

```yaml
dependencies:
  koin: ^[version]
```
### Flutter

```yaml
dependencies:
  koin: ^[version]
  koin_fluter: ^[version]
```


It has a powerful set of features.

- Have complete control of your objects (Repositors, Blocs, Stores...).
- Dispose your objects at the exact moment that you are no longer using them.
- Does not depend on the Flutter
- Combine your state management classes in a simple way.
- Standard support for the Bloc library, but it can be easily used with any state management.
- DevTools to inspect the state of your objects.
- Your dependencies are instances only when needed.
  * Its class is instant when used for the first time. Koin.dart has a implementation of [Lazy](https://www.lordcodes.com/articles/the-power-of-lazy-properties-in-kotlin) by Kotlin to provide this functionality.
- Integration with the life cycle of widgets in Flutter without depending on the context.
- Koin.dart is extensively tested.
  * Which tests were all ported from the original version, so expect the same internal behavior as the Kotlin version.
  * In addition, Koin.dart has more tests to provide coverage above 97%, to ensure the correct internal behavior.
- It is not invasive. 
  * Insert Koin.dart in your project without changing the structure of your Widgets or changing your state management package.
 


## Features

- Pragmatic
- Modules
- Scopes
- Singleton definition
- Factory definition
- Scoped definition
- Support to multiple bindings
- Support to named definition
- Easy testing
- Lazy inject
- Logging
- Support to injection parameters
- Standard support for Bloc library
- DevTools for state inspection



# Quick Start

## Declare a Koin module

```dart
// Given some classes 
class Controller {
  final BusinessService service;

  Controller(this.service);
}

class BusinessService {}

// just declare it
var myModule = Module()
  ..single((s) => Controller(s.get()))
  ..single((s) => BusinessService());
```

## Starting Koin

Use the startKoin() function to start Koin in your application.

In a Dart app:

```dart
void main(List<String> args) {
    startKoin((app){
      app.module(myModule);
    });
  }
```

In an Flutter app:

```dart
void main() {
  startKoin((app) {
    app.printLogger(level: Level.debug);
    app.module(homeModule);
  });
  runApp(MyApp());
}
```

## Injecting dependencies
```dart
class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {

    // Get a dependency
    var controller = get<Controller>();
    return Container(
      child: Text("${controller.toString()}"),
    );
  }
}
```


## Ask a Question? 🚑

- Post your question on [Stackoverflow - #koindart tag](https://stackoverflow.com/questions/tagged/koin)

## Reporting issues 💥

Found a bug on a specific feature? Open an issue on [Github issues](https://github.com/pbissonho/koin.dart/issues)

## Contribute 🛠

Want to help or share a proposal about Koin? problem on a specific feature? 

- Open an issue to explain the issue you want to solve [Open an issue](https://github.com/pbissonho/koin.dart/issues)
- After discussion to validate your ideas, you can open a PR or even a draft PR if the contribution is a big one [Current PRs](https://github.com/pbissonho/koin.dart/pulls)

## Maintainers

- [Pedro Bissonho](https://github.com/pbissonho)

## Credits

- [Arnaud Giuliani](https://github.com/arnaudgiuliani) and all contributors to the [original Koin](https://github.com/InsertKoinIO/koin) version written in Kotlin.

## Dependencies

- [Kt.dart](https://pub.dev/packages/kt_dart) port by [Pascal Welsch](https://github.com/passsy)
- [Equatable](https://pub.dev/packages/equatable) created by [Felix Angelov](https://github.com/felangel)
