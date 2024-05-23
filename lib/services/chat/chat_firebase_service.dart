import 'dart:async';
import 'package:cerrado_vivo/models/chat.dart';
import 'package:cerrado_vivo/models/chat_message.dart';
import 'package:cerrado_vivo/models/chat_user.dart';
import 'package:cerrado_vivo/services/chat/chat_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ChatFirebaseService implements ChatService {
  @override
  Future<Stream<List<ChatMessage>>> messagesStream(Chat chat) async {
    final store = FirebaseFirestore.instance;
    final conversationId = await getConversationId(chat);
    final messagesRef = store.collection('conversations').doc(conversationId).collection('messages');
  
    return messagesRef
      .orderBy('createdAt', descending: true)
      .snapshots()
      .map((snapshot) => snapshot.docs
        .map((doc) => _fromFirestore(doc, null))
        .toList());
  }


  Future<String> getConversationId(Chat chat) async {
    final store = FirebaseFirestore.instance;
    final conversationsRef = store.collection('conversations');

    final querySnapshot = await conversationsRef.where('users', isEqualTo: chat.users.toList()).limit(1).get();

    if (querySnapshot.docs.isNotEmpty) {
      return querySnapshot.docs.first.id;
    } else {
      final userIds = chat.users.toList()..sort();
      return userIds.join('_');
    }
}


  @override
  Future<ChatMessage?> save(String text, ChatUser user, Chat chat) async {
    final msg = ChatMessage(
      id: '',
      text: text,
      createdAt: DateTime.now(),
      userId: user.id,
      userName: user.name,
      userImageUrl: user.imageUrl,
    );

    final conversationsRef = FirebaseFirestore.instance.collection("conversations");
    final chatSnapshot = await conversationsRef.where('users', isEqualTo: chat.users).get();

    if (chatSnapshot.docs.isNotEmpty) {
      final chatDoc = chatSnapshot.docs.first;
      final messagesRef = chatDoc.reference.collection("messages");
      final docRef = await messagesRef
        .withConverter(
          fromFirestore: _fromFirestore,
          toFirestore: _toFirestore,
        )
        .add(msg);

      final doc = await docRef.get();
      return doc.data()!;
    } else {
      throw Exception('Erro ao obter a referência da conversa');
    }
  }

  // ChatMessage => Map<String, dynamic>
  Map<String, dynamic> _toFirestore(
    ChatMessage msg,
    SetOptions? options,
  ) {
    return {
      'text': msg.text,
      'createdAt': msg.createdAt.toIso8601String(),
      'userId': msg.userId,
      'userName': msg.userName,
      'userImageUrl': msg.userImageUrl,
    };
  }

  // Map<String, dynamic> => ChatMessage
  ChatMessage _fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> doc,
    SnapshotOptions? options,
  ) {
    return ChatMessage(
      id: doc.id,
      text: doc['text'],
      createdAt: DateTime.parse(doc['createdAt']),
      userId: doc['userId'],
      userName: doc['userName'],
      userImageUrl: doc['userImageUrl'],
    );
  }

  Future<String> _getChatCollection(Chat chat) async {
    QuerySnapshot chatSnapshot = await FirebaseFirestore.instance
        .collection('conversations')
        .where('users', isEqualTo: chat.users)
        .get();

    if (chatSnapshot.docs.length == 1) {
      return chatSnapshot.docs.first.id;
    } else {
      throw Exception('Erro ao obter a referência da conversa');
    }
  } 

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
        origins: userData['origins'],
        email: userData['email'],
        imageUrl: userData['imageUrl'] ?? 'assets/images/avatar.png',
      );
    } else {
      return null;
    }
  }
}
