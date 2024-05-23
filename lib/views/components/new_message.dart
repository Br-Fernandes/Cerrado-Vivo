import 'package:cerrado_vivo/models/chat.dart';
import 'package:cerrado_vivo/view_model/components/new_message_viewmodel.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class NewMessage extends StatefulWidget {
  final Chat chat;

  const NewMessage({super.key, required this.chat});

  @override
  State<NewMessage> createState() => _NewMessageState();
}

class _NewMessageState extends State<NewMessage> {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => NewMessageViewModel(),
      child: Consumer<NewMessageViewModel>(
        builder: (context, viewModel, child) {
          return Row(
            children: [
              Expanded(
                child: TextField(
                  controller: viewModel.messageController,
                  onChanged: (msg) => viewModel.setMessage = msg,
                  decoration: const InputDecoration(
                    labelText: 'Enviar mensagem...',
                  ),
                  onSubmitted: (_) {
                    if (viewModel.message.trim().isNotEmpty) {
                      viewModel.sendMessage(widget.chat);
                    }
                  },
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: viewModel.message.trim().isEmpty
                    ? null
                    : () => viewModel.sendMessage(widget.chat),
              ),
            ],
          );
        },
      ),
    );
  }
}