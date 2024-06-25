import 'package:cerrado_vivo/models/chat.dart';
import 'package:cerrado_vivo/services/chat/conversation_firebase_service.dart';
import 'package:cerrado_vivo/modelview/components/chat_card_view_model.dart';
import 'package:cerrado_vivo/views/pages/chat_page.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatCard extends StatefulWidget {
  final Chat chat;

  const ChatCard({super.key, required this.chat});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  late final ChatCardViewModel _viewModel;

  @override
  void initState() {
    super.initState();
    _viewModel = ChatCardViewModel(
      conversationFirebaseService: ConversationFirebaseService()
    );
    _viewModel.getOtherUser(widget.chat);
    _viewModel.getLastMessage(widget.chat);
  }

  @override
  Widget build(BuildContext context) {
    if (_viewModel.otherUser == null) {
      return const SizedBox
          .shrink(); // Retorna um widget vazio enquanto o _otherUser é nulo
    }

    return ChangeNotifierProvider(
      create: (_) => _viewModel,
      child: Consumer<ChatCardViewModel>(
        builder: (context, viewModel, child) {
          return Container(
            width: double.infinity,
            height: 100,
            decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.grey, width: 1))),
            child: TextButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) => ChatPage(
                          chat: widget.chat,
                        )));
              },
              child: Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(10),
                    child: CircleAvatar(
                      backgroundImage: viewModel.showUserImage(viewModel.otherUser!.imageUrl),
                      radius: 80 / 2,
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        viewModel.otherUser!.name,
                        style: const TextStyle(
                            fontSize: 19,
                            fontWeight: FontWeight.bold,
                            color: Colors.black),
                      ),
                      Text(
                        viewModel.lastMessage ?? '...',
                        textAlign: TextAlign.left,
                        style: const TextStyle(
                          color: Colors.grey,
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        }
      )
    );
  }
}
