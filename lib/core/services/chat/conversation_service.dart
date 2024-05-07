import 'package:cerrado_vivo/core/models/chat.dart';

abstract class ConversationService {
  Future<Stream<List<Chat>>> conversationsStream();

}