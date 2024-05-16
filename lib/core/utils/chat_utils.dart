import 'package:cerrado_vivo/core/models/chat.dart';
import 'package:cerrado_vivo/core/models/chat_user.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatUtils {
  static final ChatUtils _instance = ChatUtils._internal();

  factory ChatUtils() {
    return _instance;
  }

  ChatUtils._internal();

  Future<ChatUser?> getOtherUser(Chat chat) async {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    final otherUserId = chat.users.firstWhere((user) => user != currentUser);
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(otherUserId);
    final userSnapshot = await userDocRef.get();

    if (userSnapshot.exists) {
      final userData = userSnapshot.data()!;
      return ChatUser(
        id: userSnapshot.id,
        name: userData['name'],
        email: userData['email'],
        imageUrl: userData['imageUrl'] ?? 'assets/images/avatar.png',
      );
    } else {
      return null;
    }
  }

  bool belongsToCurrentUser(String idUser) {
    final auth = FirebaseAuth.instance;
    final currentUser = auth.currentUser!.uid;
    print(currentUser);

    return currentUser == idUser;
  }

}