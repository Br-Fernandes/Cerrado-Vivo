import 'package:cerrado_vivo/models/chat.dart';

abstract class ConversationService {
  Future<Stream<List<Chat>>> conversationsStream();

}