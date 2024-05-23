import 'package:cerrado_vivo/models/chat.dart';
import 'package:cerrado_vivo/services/chat/conversation_firebase_service.dart';
import 'package:cerrado_vivo/view_model/pages/conversations_view_model.dart';
import 'package:cerrado_vivo/views/components/chat_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConversationsPage extends StatefulWidget {
  const ConversationsPage({super.key});

  @override
  State<ConversationsPage> createState() => _ConversationsPageState();
}

class _ConversationsPageState extends State<ConversationsPage> {
  late final ConversationsViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ConversationsViewModel(
      conversationService: ConversationFirebaseService(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => _viewModel,
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: const Color(0xFF53AC3C),
          title: const Text(
            "Conversas",
            style: TextStyle(color: Colors.white),
          ),
          leading: Consumer<ConversationsViewModel>(
            builder: (context, viewModel, child) {
              return IconButton(
                icon: const Icon(
                  Icons.arrow_back,
                  color: Colors.white,
                ),
                onPressed: () => viewModel.navigateBack(context),
              );
            },
          ),
          centerTitle: true,
        ),
        body: FutureBuilder<Stream<List<Chat>>>(
          future: _viewModel.getConversationsStream(),
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
      ),
    );
  }
}
