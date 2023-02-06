import 'package:flutter_modular/flutter_modular.dart';
import 'package:mobx/mobx.dart';

import '../../../core/helpers/logger.dart';
import '../../../core/ui/widgets/loader.dart';
import '../../../core/ui/widgets/messages.dart';
import '../../../services/user_service.dart';

part 'register_store.g.dart';

class RegisterStore = RegisterStoreBase with _$RegisterStore;

abstract class RegisterStoreBase with Store {
  final UserService _service;
  final Logger _log;

  RegisterStoreBase({
    required UserService service,
    required Logger log,
  })  : _service = service,
        _log = log;

  @action
  Future<void> register(String name, String email, String password) async {
    try {
      Loader.show();
      await _service.register(name, email, password);
      Loader.hide();
      Modular.to.popAndPushNamed('/auth/');
    } catch (e, s) {
      _log.error('Erro ao registrar usuario', e, s);
      Loader.hide();
      Messages.alert('Erro ao registrar usuário, tente novamente mais tarde');
    }
  }
}
