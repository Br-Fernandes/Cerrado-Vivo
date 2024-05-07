import 'package:cerrado_vivo/components/chat_card.dart';
import 'package:cerrado_vivo/core/models/chat.dart';
import 'package:cerrado_vivo/core/services/chat/chat_service.dart';
import 'package:cerrado_vivo/core/services/chat/conversation_firebase_service.dart';
import 'package:flutter/material.dart';

class ConversationsPage extends StatelessWidget {
  const ConversationsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xFF53AC3C),
        title: Text(
          "Conversas",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Chat>>(
        stream: _getConversationsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final conversations = snapshot.data!;
            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final chat = conversations[index];
                return ChatCard(chat: chat);
              },
            );
          } else if (snapshot.hasError) {
            print(snapshot.error.toString());
            return Center(
              child: Text('${snapshot.error}'),
            );
          } else {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }

  Stream<List<Chat>> _getConversationsStream() async* {
    final conversationService = ConversationFirebaseService();
    final Stream<List<Chat>> conversationsStream =
        await conversationService.conversationsStream();
    yield* conversationsStream;
  }
}
