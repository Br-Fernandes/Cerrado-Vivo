import 'package:cerrado_vivo/models/chat.dart';
import 'package:cerrado_vivo/models/chat_message.dart';
import 'package:cerrado_vivo/utils/constants.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ConversationController extends GetxController {
  Stream<List<Chat>> conversationsStream() {
    final currentUser = firebaseAuth.currentUser;
    if (currentUser != null) {
      String currentUserId = currentUser.uid;
      print("Current user ID: $currentUserId");

      return firestore
          .collection('conversations')
          .where('users', arrayContains: currentUserId)
          .snapshots()
          .asyncMap((chatQuerySnapshot) async {
        print("Number of conversations: ${chatQuerySnapshot.docs.length}");
        final chatDocs = chatQuerySnapshot.docs;

        final chatList = await Future.wait(chatDocs.map((doc) async {
          final data = doc.data();
          final messageQuerySnapshot = await doc.reference.collection('messages').get();
          print("Number of messages in conversation: ${messageQuerySnapshot.docs.length}");
          
          final messages = await Future.wait(messageQuerySnapshot.docs.map((messageDoc) async {
            return await _chatMessageFromFirestore(messageDoc);
          }));

          return Chat(
            users: List<String>.from(data['users']),
            messages: messages,
          );
        }));

        return chatList;
      });
    } else {
      print('Usuário atual é nulo');
      return Stream.value([]);
    }
  }

  static Future<ChatMessage> _chatMessageFromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    [SnapshotOptions? options]
  ) async {
    final data = snapshot.data()!;
    return ChatMessage(
      id: snapshot.id,
      text: data['text'],
      createdAt: DateTime.parse(data['createdAt'] as String),
      userId: data['userId'],
      userName: data['userName'],
      userImageUrl: data['userImageUrl'],
    );
  }

  Future<String> getLastMessage(Chat chat) async {
    final store = FirebaseFirestore.instance;
    final docSnapshot = await store.collection('conversations').where('users', isEqualTo: chat.users).get();
    final doc = docSnapshot.docs.first;

    final messageRef = doc.reference.collection('messages');
    final messagesSnapshot = await messageRef.orderBy('createdAt', descending: true).limit(1).get();

    if (messagesSnapshot.docs.isNotEmpty) {
      final lastMessage = messagesSnapshot.docs.first.data()['text'] as String;
      return lastMessage;
    } else {
      return '';
    }
  }
}
