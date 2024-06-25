import 'package:cerrado_vivo/models/chat.dart';
import 'package:cerrado_vivo/models/user_app.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatUtils {
  static final ChatUtils _instance = ChatUtils._internal();

  factory ChatUtils() {
    return _instance;
  }

  ChatUtils._internal();

  Future<UserApp > getCurrentUser() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    final userDocRef = await FirebaseFirestore.instance
      .collection('users')
      .doc(currentUser?.uid).get();

    return toChatUser(userDocRef);

  }

  Future<UserApp ?> getOtherUser(Chat chat) async {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    final otherUserId = chat.users.firstWhere((user) => user != currentUser);
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(otherUserId);
    final userSnapshot = await userDocRef.get();

    if (userSnapshot.exists) {
      final userData = userSnapshot.data()!;
      return UserApp (
        id: userSnapshot.id,
        name: userData['name'],
        email: userData['email'],
        imageUrl: userData['imageUrl'] ?? 'assets/images/avatar.png',
      );
    } else {
      return null;
    }
  }

  static UserApp  toChatUser(DocumentSnapshot<Map<String, dynamic>> user) {
    return UserApp (
      id: user.id,
      name: user['name'],
      email: user['email'],
      imageUrl: user['imageUrl'] ?? 'assets/images/avatar.png',
    );
  }

  bool belongsToCurrentUser(String idUser) {
    final auth = FirebaseAuth.instance;
    final currentUser = auth.currentUser!.uid;

    return currentUser == idUser;
  }
}