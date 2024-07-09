import 'dart:io';

import 'package:cerrado_vivo/models/user_app.dart';
import 'package:cerrado_vivo/utils/constants.dart';
import 'package:cerrado_vivo/views/pages/home_page.dart';
import 'package:cerrado_vivo/views/pages/login_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  static AuthController instance = Get.find();

  late Rx<UserApp?> _currentUser;
  //instancia para verificação de usuario
  late Rx<User?> _user;

  UserApp? get currentUser => _currentUser.value;

  @override
  void onReady() {
    super.onReady();
    _user = Rx<User?>(firebaseAuth.currentUser);
    ever(_user, _setInitialScreen);
  }

  AuthController() {
    _currentUser = Rx<UserApp?>(null);
    _initCurrentUser();
  }

  void _setInitialScreen(User? user) {
    if(user != null) {
      print('logou');
      Get.offAll(const HomePage());
    } else {
      print(' não logou');
      Get.offAll(const LoginPage());
    }
  }

  Future<void> _initCurrentUser() async {
    final currentFirebaseUser = firebaseAuth.currentUser;
    if (currentFirebaseUser != null) {
      _currentUser.value = await toUserApp(currentFirebaseUser) as UserApp;
    } else {
      _currentUser.value = null;
    }
  }

  Future<bool> signup(
    String name,
    String email,
    String password,
    File? image,
  ) async {
    try {
      UserCredential credential = await firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      if (credential.user != null) {
        // 1. Upload da foto do usuário
        final imageName = '${credential.user!.uid}.jpg';
        final imageUrl = await _uploadUserImage(image, imageName);

        // 2. Atualizar os atributos do usuário
        await credential.user?.updateDisplayName(name);
        await credential.user?.updatePhotoURL(imageUrl);

        // 2.5 Fazer o login do usuário
        await login(email, password);

        // 3. Salvar usuário no banco de dados (opcional)
        final chatUser = UserApp(
          id: credential.user!.uid,
          name: name,
          email: email,
          imageUrl: imageUrl ?? 'assets/images/avatar.png',
        );
        await _saveChatUser(chatUser);
        _currentUser.value = chatUser;

        return true;
      }
    } catch (e) {
      print("Erro durante o cadastro: $e");
    }
    return false;
  }

  Future<bool> login(String email, String password) async {
    try {
      UserCredential credential = await firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (credential.user != null) {
        _currentUser.value = await toUserApp(credential.user!) as UserApp;
        return true;
      }
    } catch (e) {
      rethrow;
    }
    return false;
  }

  Future<void> logout() async {
    try {
      await firebaseAuth.signOut();
      _currentUser.value = null;
    } catch (e) {
      rethrow;
    }
  }

  Future<String?> _uploadUserImage(File? image, String imageName) async {
    if (image == null) return null;

    final imageRef = firebaseStorage.ref().child('user_images').child(imageName);
    await imageRef.putFile(image).whenComplete(() {});
    return await imageRef.getDownloadURL();
  }

  Future<void> _saveChatUser(UserApp user) async {
    final docRef = firestore.collection('users').doc(user.id);
    await docRef.set({
      'name': user.name,
      'email': user.email,
      'imageUrl': user.imageUrl,
      'bio': user.bio.value,
      'location': user.location.value
    });
  }

  static bool checkLoginStatus() {
    final currentUser = FirebaseAuth.instance.currentUser;
    return currentUser != null;
  }

  Future<UserApp?> toUserApp(User user, [String? name, String? imageUrl]) async {
  try {
    DocumentSnapshot userDoc = await firestore.collection('users').doc(user.uid).get();
    if (userDoc.exists) {
      Map<String, dynamic>? userData = userDoc.data() as Map<String, dynamic>?;
      if (userData != null) {
        return UserApp(
          id: userDoc.id,
          name: userData['name'] as String,
          email: userData['email'] as String,
          imageUrl: userData['imageUrl'] as String,
          userBio: userData['bio'] as String,
        );
      }
    } else {
      return UserApp(
      id: user.uid,
      name: name ?? user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageUrl: imageUrl ?? user.photoURL ?? 'assets/images/avatar.png',
    );
    }
    return null;
  } catch (error) {
    print('Erro ao buscar usuário do Firestore: $error');
    return null;
  }
}

}


