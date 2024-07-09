import 'dart:io';

import 'package:cerrado_vivo/models/chat.dart';
import 'package:cerrado_vivo/models/user_app.dart';
import 'package:cerrado_vivo/services/chat/conversation_firebase_service.dart';
import 'package:cerrado_vivo/utils/chat_utils.dart';
import 'package:cerrado_vivo/views/pages/chat_page.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
  final Chat chat;

  const ChatCard({super.key, required this.chat});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  UserApp? _otherUser;
  String? _lastMessage;
  static const _defaultImage = 'assets/images/avatar.png';

  @override
  void initState() {
    super.initState();
    _fetchChatDetails();
  }

  Future<void> _fetchChatDetails() async {
    _otherUser = await ChatUtils().getOtherUser(widget.chat);
    _lastMessage = await ConversationFirebaseService().getlastMessage(widget.chat);
    setState(() {}); // Atualiza o estado para refletir as mudanças na UI
  }

  ImageProvider _showUserImage(String imageUrl) {
    final uri = Uri.parse(imageUrl);
    if (uri.path.contains(_defaultImage)) {
      return const AssetImage(_defaultImage);
    } else if (uri.scheme.contains('http')) {
      return NetworkImage(uri.toString());
    } else {
      return FileImage(File(uri.toString()));
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_otherUser == null) {
      return const SizedBox.shrink(); // Retorna um widget vazio enquanto o _otherUser é nulo
    }

    return Container(
      width: double.infinity,
      height: 100,
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.grey, width: 1)),
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => ChatPage(chat: widget.chat),
          ));
        },
        child: Row(
          children: [
            Container(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundImage: _showUserImage(_otherUser!.imageUrl),
                radius: 40,
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _otherUser!.name,
                  style: const TextStyle(
                    fontSize: 19,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                Text(
                  _lastMessage ?? '...',
                  textAlign: TextAlign.left,
                  style: const TextStyle(
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
