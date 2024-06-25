import 'package:cerrado_vivo/controllers/conversation_controller.dart';
import 'package:cerrado_vivo/models/chat.dart';
import 'package:cerrado_vivo/modelview/pages/conversations_view_model.dart';
import 'package:cerrado_vivo/views/components/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

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
        leading:  IconButton(
          icon: const Icon(
            Icons.arrow_back,
            color: Colors.white,
          ),
          onPressed: () => Get.back()
            
        ),
        centerTitle: true,
      ),
      body: FutureBuilder<Stream<List<Chat>>>(
        future: conversationController.conversationsStream(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return StreamBuilder<List<Chat>>(
              stream: snapshot.data,
              builder: (context, conversationsSnapshot) {
                if (conversationsSnapshot.hasData) {
                  final conversations = conversationsSnapshot.data!;
                  return ListView.builder(
                    itemCount: conversations.length,
                    itemBuilder: (context, index) {
                      final chat = conversations[index];
                      return ChatCard(chat: chat);
                    },
                  );
                } else if (conversationsSnapshot.hasError) {
                  return Center(
                    child: Text('${conversationsSnapshot.error}'),
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              },
            );
          } else if (snapshot.hasError) {
            return Center(
              child: Text('${snapshot.error}'),
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
