import '../core/helpers/logger.dart';
import '../repository/user_repository.dart';
import './user_service.dart';

class UserServiceImpl implements UserService {
  final UserRepository _repository;
  final Logger _log;

  UserServiceImpl({
    required UserRepository repository,
    required Logger log,
  })  : _repository = repository,
        _log = log;

  @override
  Future<void> register(String name, String email, String password) async {
    await _repository.register(email, password);
  }
}
