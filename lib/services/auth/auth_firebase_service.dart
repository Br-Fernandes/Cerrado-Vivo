import 'dart:io';
import 'dart:async';
import 'package:cerrado_vivo/models/chat_user.dart';
import 'package:cerrado_vivo/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthFirebaseService implements AuthService {


  static ChatUser? _currentUser;
  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      _currentUser = user == null ? null : toChatUser(user);
      controller.add(_currentUser);
    }
  });

  @override
  ChatUser? get currentUser {
    return _currentUser;
  }

  @override
  Stream<ChatUser?> get userChanges {
    return _userStream;
  }

  Future<bool> signup(
      String name, String origins, String email, String password, File? image) async {

    try {
      final auth = FirebaseAuth.instance;

      UserCredential credential = await auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // 1. Upload da foto do usuário
        final imageName = '${credential.user!.uid}.jpg';
        final imageUrl = await _uploadUserImage(image, imageName);

        // 2. atualizar os atributos do usuário
        await credential.user?.updateDisplayName(name);
        await credential.user?.updatePhotoURL(imageUrl);

        // 2.5 fazer o login do usuário
        await login(email, password);

        // 3. salvar usuário no banco de dados (opcional)
        _currentUser = toChatUser(credential.user!, name, origins, imageUrl);
        await _saveChatUser(_currentUser!);

        return true;
      }
    } catch (e) {
      print("Erro durante o cadastro: $e");
    }
    return false;
  }

  @override
  Future<bool> login(String email, String password) async {
    UserCredential credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );

    if (credential.user != null) return true;
    
    return false;
  }

  @override
  Future<void> logout() async {
    FirebaseAuth.instance.signOut();
  }

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;

    final storage = FirebaseStorage.instance;
    final imageRef = storage.ref().child('user_images').child(imageName);
    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  Future<void> _saveChatUser(ChatUser user) async {
    final store = FirebaseFirestore.instance;
    final docRef = store.collection('users').doc(user.id);

    print(user.origins);

    return docRef.set({
      'name': user.name,
      'origins': user.origins,
      'email': user.email,
      'imageUrl': user.imageUrl,
    });
  }

  static bool checkLoginStatus() {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null;
  }


  static ChatUser toChatUser(User user, [String? name, String? origins, String? imageUrl]) {
    return ChatUser(
      id: user.uid,
      name: name ?? user.displayName ?? user.email!.split('@')[0],
      origins: origins ?? '',
      email: user.email!,
      imageUrl: imageUrl ?? user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
