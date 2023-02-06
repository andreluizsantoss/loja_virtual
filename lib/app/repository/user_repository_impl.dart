import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../core/exceptions/failure_exception.dart';
import '../core/helpers/logger.dart';
import './user_repository.dart';

class UserRepositoryImpl implements UserRepository {
  final Logger _log;

  UserRepositoryImpl({
    required Logger log,
  }) : _log = log;

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;

  @override
  Future<void> register(String email, String password) async {
    try {
      await auth.createUserWithEmailAndPassword(
        email: email.toString(),
        password: password.toString(),
      );
    } on FirebaseException catch (e) {
      _log.error('Erro ao criar o usuario', e);
      throw FailureException();
    }
  }
}
