import 'dart:io';
import 'dart:async';
import 'package:cerrado_vivo/core/models/chat_user.dart';
import 'package:cerrado_vivo/core/services/auth/auth_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';

class AuthFirebaseService implements AuthService {


  static ChatUser? _currentUser;
  static final _userStream = Stream<ChatUser?>.multi((controller) async {
    final authChanges = FirebaseAuth.instance.authStateChanges();
    await for (final user in authChanges) {
      print("antes de tentar pegar o currentuser");
      _currentUser = user == null ? null : toChatUser(user);
      controller.add(_currentUser);
      print(_currentUser);
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

  Future<void> signup(
      String name, String email, String password, File? image) async {
    //await Firebase.initializeApp(
    //    options: FirebaseOptions(
    //  apiKey: 'AIzaSyBQsGGJBvCbJAUI45Ee2W-L3KNy6MT43us',
    //  appId: '1:391385942371:android:d43084aa7e1498052e6b56',
    //  messagingSenderId: 'sendid',
    //  projectId: 'cerrado-vivo',
    //  storageBucket: 'cerrado-vivo.appspot.com',
    //));

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
        _currentUser = toChatUser(credential.user!, name, imageUrl);
        await _saveChatUser(_currentUser!);
      }
    } catch (e) {
      print("Erro durante o cadastro: $e");
      // Trate o erro conforme necessário
    }
  }

  @override
  Future<void> login(String email, String password) async {
    //await Firebase.initializeApp(
    //    options: FirebaseOptions(
    //  apiKey: 'AIzaSyBQsGGJBvCbJAUI45Ee2W-L3KNy6MT43us',
    //  appId: '1:391385942371:android:d43084aa7e1498052e6b56',
    //  messagingSenderId: 'sendid',
    //  projectId: 'cerrado-vivo',
    //  storageBucket: 'cerrado-vivo.appspot.com',
    //));

    await FirebaseAuth.instance.signInWithEmailAndPassword(
      email: email,
      password: password,
    );
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

    return docRef.set({
      'name': user.name,
      'email': user.email,
      'imageUrl': user.imageUrl,
    });
  }

  static ChatUser toChatUser(User user, [String? name, String? imageUrl]) {
    return ChatUser(
      id: user.uid,
      name: name ?? user.displayName ?? user.email!.split('@')[0],
      email: user.email!,
      imageUrl: imageUrl ?? user.photoURL ?? 'assets/images/avatar.png',
    );
  }
}
