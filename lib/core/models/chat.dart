import 'package:cerrado_vivo/core/models/chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class Chat {
  final List<String> users;
  final List<ChatMessage> messages;

  Chat({required this.users, required this.messages});

  toJson() {
    return {
      'users': users,
      'messages': messages.map((e) => e.toJson()).toList(),
    };
  }

  factory Chat.fromSnapshot(DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    final messageData = data['messages'] as List<dynamic>;
    final messages = messageData.map((m) => ChatMessage.fromMap(m as Map<String, dynamic>)).toList();

    return Chat(
      users: List<String>.from(data['users']),
      messages: messages,
    );
  }
}
