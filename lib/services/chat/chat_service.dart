
import 'package:cerrado_vivo/models/chat.dart';
import 'package:cerrado_vivo/models/chat_message.dart';
import 'package:cerrado_vivo/models/user_app.dart';
import 'package:cerrado_vivo/services/chat/chat_firebase_service.dart';

abstract class ChatService {
  Future<Stream<List<ChatMessage>>> messagesStream(Chat chat);
  Future<ChatMessage?> save(String texto, UserApp user, Chat chat);

  factory ChatService() {
    return ChatFirebaseService();
  }
}
