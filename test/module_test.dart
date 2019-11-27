import 'package:koin/koin.dart';
import 'package:koin/src/core/global_context.dart';
import 'package:koin/src/core/logger.dart';
import 'package:koin/src/core/module.dart';
import 'package:koin/src/core/qualifier.dart';
import 'package:koin/src/koin_application.dart';
import 'package:test/test.dart';

abstract class IService {
  void dispose();
}

class ServiceImpl implements IService {
  void dispose() {}
}

abstract class IAuthService {
  void dispose();
}

class Carro {}

class Moto {}

class AuthServiceImpl implements IAuthService {
  @override
  void dispose() {
    print("AuthServiceImpl closed");
  }
}

var appModule = Module()
  ..single<IService>((s, p) => ServiceImpl())
      .bind(ServiceImpl)
      .onClose((service) {});

var authModule = Module()
  ..single<IAuthService>((s, p) => AuthServiceImpl())
      .bind(AuthServiceImpl)
      .onClose((service) => service.dispose())
  ..scopeOld(named("myScope")).scoped<IAuthService>();

var scopeName = named("MY_SCOPE");

var scopeName2 = named("MY_SCOPE2");

var scopeModule = Module()
  ..factory<IAuthService>((s, p) => AuthServiceImpl())
  ..factory<Moto>((s, p) => Moto())
  ..single<IService>((s, p) => ServiceImpl());

void main() {
  test("start koin", () {
    var koinApp = startKoin((app) {
      app.printLogger();
      app.modules([appModule, authModule]);
    });

    var service = koinApp.koin.get<IService>(null, null);
    var serviceBind = koinApp.koin.get<ServiceImpl>(null, null);
    expect(service, isNotNull);
    expect(serviceBind, isNotNull);
    var equas = service = serviceBind;

    expect(true, equas);
  });

  test("get definition from a scope", () {
    var koin = KoinApplication().module(scopeModule).koin;

    var scope = koin.createScope("myScope", scopeName);

    var service = scope.get<IService>(null, null);
    var service2 = scope.get<IService>(null, null);
    var scopeT = koin.getScope("myScope");
    var result = scopeT.get<IService>(null, null);
    var equas = service == service2 && service2 == result;

    expect(true, equas);
  });

  test("tempo", () {
    Logger.setLogger(EmptyLogger(Level.info));

    var app = KoinApplication()
      ..module(scopeModule)
      ..setLogger(EmptyLogger(Level.info));

    var koin = app.koin;
    // var scope = koin.createScope("myScope", scopeName);
    // var service = koin.get<IService>(null, null);

    var result = Measure.measureMicroseconds(() {
      for (int i = 0; i < 2000; i++) {
        var service = koin.rootScope.get<IService>();
      }
    });

    print("${result}micro");
  });
}