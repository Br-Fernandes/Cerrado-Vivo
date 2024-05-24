import 'dart:io';
import 'package:cerrado_vivo/models/chat_user.dart';
import 'package:cerrado_vivo/services/auth/auth_firebase_service.dart';

abstract class AuthService {
  ChatUser? get currentUser;

  Stream<ChatUser?> get userChanges;

  Future<bool> signup(
    String name,
    String origins,
    String email,
    String password,
    File? image,
  );

  Future<bool> login(
    String email,
    String password,
  );

  Future<void> logout();

  factory AuthService() {
    // return AuthMockService();
    return AuthFirebaseService();
  }
}
