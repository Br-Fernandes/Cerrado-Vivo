import 'package:cerrado_vivo/models/chat.dart';
import 'package:cerrado_vivo/services/auth/auth_firebase_service.dart';
import 'package:cerrado_vivo/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class NewMessageViewModel extends ChangeNotifier {
  String _message = '';
  final _messageController = TextEditingController();

  String get message => _message;
  set setMessage(String msg) {
    _message = msg;
    notifyListeners();
  }

  TextEditingController get messageController => _messageController;

  Future<void> sendMessage(Chat chat) async {
    if (_message.trim().isNotEmpty) {
      final user = AuthFirebaseService().currentUser;
      await ChatService().save(_message, user!, chat);
      _messageController.clear();
      _message = '';
      notifyListeners();
    }
  }
}