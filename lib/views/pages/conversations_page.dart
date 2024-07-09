import 'package:cerrado_vivo/controllers/conversation_controller.dart';
import 'package:cerrado_vivo/models/chat.dart';
import 'package:cerrado_vivo/views/components/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  final ConversationController conversationController = Get.put(ConversationController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color(0xFF53AC3C),
        title: const Text(
          "Conversas",
          style: TextStyle(color: Colors.white),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Get.back(),
        ),
        centerTitle: true,
      ),
      body: StreamBuilder<List<Chat>>(
        stream: conversationController.conversationsStream(),
        builder: (context, conversationsSnapshot) {
          if (conversationsSnapshot.hasData) {
            final conversations = conversationsSnapshot.data!;
            print("Number of conversations in UI: ${conversations.length}");
            return ListView.builder(
              itemCount: conversations.length,
              itemBuilder: (context, index) {
                final chat = conversations[index];
                return ChatCard(chat: chat);
              },
            );
          } else if (conversationsSnapshot.hasError) {
            print("Error in StreamBuilder: ${conversationsSnapshot.error}");
            return Center(
              child: Text('${conversationsSnapshot.error}'),
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
