import 'package:cerrado_vivo/core/models/chat.dart';
import 'package:cerrado_vivo/core/models/chat_message.dart';
import 'package:cerrado_vivo/core/services/chat/conversation_service.dart';
import 'package:cerrado_vivo/core/utils/chat_utils.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConversationFirebaseService implements ConversationService {
  @override
  Future<Stream<List<Chat>>> conversationsStream() async {
    final currentUser = FirebaseAuth.instance.currentUser;
    if (currentUser != null) {
      String currentUserId = currentUser.uid;
      final chatQuerySnapshot = await FirebaseFirestore.instance
          .collection('conversations')
          .where('users', arrayContains: currentUserId)
          .get();
    
      final chatDocs = chatQuerySnapshot.docs;
    
      final chatList = await Future.wait(chatDocs.map((doc) async {
        final data = doc.data();
        final messageQuerySnapshot = await doc.reference.collection('messages').get();
        final messages = await Future.wait(messageQuerySnapshot.docs.map((messageDoc) async {
          return await _chatMessageFromFirestore(messageDoc);
        }));
    
        return Chat(
          users: List<String>.from(data['users']),
          messages: messages,
        );
      }));
    
      return Stream.value(chatList);
    } else {
      // Lidar com o caso em que o usuário atual é nulo
      return const Stream.empty();
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

  Future<String> getlastMessage(Chat chat) async {
    final store = FirebaseFirestore.instance;
    final docSnapshot =  await store.collection('conversations').where('users', isEqualTo: chat.users).get();
    final doc = docSnapshot.docs.first;

    final messageRef = doc.reference.collection('messages');
    final messagesSnapshot = await messageRef.orderBy('createdAt', descending: true)
      .limit(1)
      .get();

    if(messagesSnapshot.docs.isNotEmpty) {
      final lastMessage = messagesSnapshot.docs.first.data()['text'] as String;
       return lastMessage; // ChatUtils().belongsToCurrentUser(messagesSnapshot.docs.first.data()['idUser'])
        // ? 'Você: $lastMessage'
        // : lastMessage;
    } else {
      return '';
    }  
  }
  
}