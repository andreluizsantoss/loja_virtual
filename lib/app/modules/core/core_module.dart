import 'package:flutter_modular/flutter_modular.dart';

import '../../core/helpers/logger.dart';
import '../../repository/user_repository.dart';
import '../../repository/user_repository_impl.dart';
import '../../services/user_service.dart';
import '../../services/user_service_impl.dart';
import 'auth/auth_store.dart';

class CoreModule extends Module {
  @override
  final List<Bind> binds = [
    Bind.lazySingleton(
      (i) => AuthStore(),
      export: true,
    ),
    Bind.lazySingleton<Logger>(
      (i) => LoggerImpl(),
      export: true,
    ),
    Bind.lazySingleton<UserRepository>(
      (i) => UserRepositoryImpl(
        log: i(),
      ),
      export: true,
    ),
    Bind.lazySingleton<UserService>(
      (i) => UserServiceImpl(
        repository: i(),
        log: i(),
      ),
      export: true,
    ),
  ];
}
