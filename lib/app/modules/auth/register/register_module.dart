import 'package:flutter_modular/flutter_modular.dart';

import 'register_page.dart';
import 'register_store.dart';

class RegisterModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => RegisterStore(
        service: i(),
        log: i(),
      ),
    ),
  ];

  @override
  final List<ModularRoute> routes = [
    ChildRoute(
      '/',
      child: (_, args) => const RegisterPage(),
    ),
  ];
}
