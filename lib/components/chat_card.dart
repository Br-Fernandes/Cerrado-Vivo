import 'dart:io';

import 'package:cerrado_vivo/core/models/chat.dart';
import 'package:cerrado_vivo/core/models/chat_user.dart';
import 'package:cerrado_vivo/core/services/chat/conversation_firebase_service.dart';
import 'package:cerrado_vivo/core/utils/chat_utils.dart';
import 'package:cerrado_vivo/pages/chat_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ChatCard extends StatefulWidget {
  final Chat chat;

  const ChatCard({super.key, required this.chat});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  ChatUser? _otherUser;
  String? _lastMessage;
  static const _defaultImage = 'assets/images/avatar.png';

  @override
  void initState() {
    super.initState();
    _getOtherUser();
    _getLastMessage();
  }

  @override
  Widget build(BuildContext context) {
    if (_otherUser == null) {
      return const SizedBox
          .shrink(); // Retorna um widget vazio enquanto o _otherUser é nulo
    }

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
              child: _showUserImage(_otherUser!.imageUrl, 80),
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
                      color: Colors.black),
                ),
                Text(
                  _lastMessage ?? '...',
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

  Future<void> _getOtherUser() async {
    _otherUser = await ChatUtils().getOtherUser(widget.chat);
    setState(() {});
  }

  Future<void> _getLastMessage() async {
    _lastMessage =
        await ConversationFirebaseService().getlastMessage(widget.chat);
    setState(() {});
  }

  Widget _showUserImage(String imageUrl, double size) {
    ImageProvider? provider;
    final uri = Uri.parse(imageUrl);

    if (uri.path.contains(_defaultImage)) {
      provider = const AssetImage(_defaultImage);
    } else if (uri.scheme.contains('http')) {
      provider = NetworkImage(uri.toString());
    } else {
      provider = FileImage(File(uri.toString()));
    }

    return CircleAvatar(
      backgroundImage: provider,
      radius: size / 2,
    );
  }
}
