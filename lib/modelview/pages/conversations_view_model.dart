import 'package:cerrado_vivo/models/chat.dart';
import 'package:cerrado_vivo/services/chat/conversation_firebase_service.dart';
import 'package:flutter/material.dart';

class ConversationsViewModel extends ChangeNotifier {
  final ConversationFirebaseService _conversationService;

  ConversationsViewModel({required ConversationFirebaseService conversationService})
      : _conversationService = conversationService;

  Future<Stream<List<Chat>>> getConversationsStream() async {
    return _conversationService.conversationsStream();
  }

  void navigateBack(BuildContext context) {
    Navigator.of(context).pop();
  }
}
