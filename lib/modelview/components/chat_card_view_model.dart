import 'dart:io';

import 'package:cerrado_vivo/models/chat.dart';
import 'package:cerrado_vivo/models/user_app.dart';
import 'package:cerrado_vivo/services/chat/conversation_firebase_service.dart';
import 'package:cerrado_vivo/utils/chat_utils.dart';
import 'package:flutter/material.dart';

class ChatCardViewModel extends ChangeNotifier {
  final ConversationFirebaseService _conversationFirebaseService;

  ChatCardViewModel({required ConversationFirebaseService conversationFirebaseService}) : _conversationFirebaseService = conversationFirebaseService;

  UserApp? _otherUser;
  String? _lastMessage;
  static const _defaultImage = 'assets/images/avatar.png';

  UserApp? get otherUser => _otherUser;
  String? get lastMessage => _lastMessage;
  String get defaultImage => _defaultImage;

  Future<void> getOtherUser(Chat chat) async {
    _otherUser = await ChatUtils().getOtherUser(chat);
    notifyListeners();
  }

  Future<void> getLastMessage(Chat chat) async {
    _lastMessage =
        await _conversationFirebaseService.getlastMessage(chat);
    notifyListeners();
  }

  ImageProvider showUserImage(String imageUrl) {
    ImageProvider? provider;
    final uri = Uri.parse(imageUrl);

    if (uri.path.contains(_defaultImage)) {
      provider = const AssetImage(_defaultImage);
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }
    return provider;
  }
}