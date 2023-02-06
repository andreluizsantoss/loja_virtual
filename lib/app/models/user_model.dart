import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  String? id;
  String? name;
  String? email;
  String? password;

  UserModel({
    this.id,
    this.name,
    this.email,
    this.password,
  });

  UserModel.empty()
      : id = '',
        name = '',
        email = '',
        password = '';

  UserModel.fromDocument(DocumentSnapshot<Map<String, dynamic>>? document)
      : id = document?.id ?? '',
        name = document?['name'] ?? '',
        email = document?['email'] ?? '';

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': name,
      'email': email,
    };
  }
}
