
import 'package:cerrado_vivo/core/models/chat.dart';
import 'package:cerrado_vivo/core/models/chat_message.dart';
import 'package:cerrado_vivo/core/models/chat_user.dart';
import 'package:cerrado_vivo/core/services/chat/chat_firebase_service.dart';

abstract class ChatService {
  Future<Stream<List<ChatMessage>>> messagesStream(Chat chat);
  Future<ChatMessage?> save(String texto, ChatUser user, Chat chat);

  factory ChatService() {
    return ChatFirebaseService();
  }
}
