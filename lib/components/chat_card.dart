import 'dart:io';

import 'package:cerrado_vivo/core/models/chat.dart';
import 'package:cerrado_vivo/core/models/chat_user.dart';
import 'package:cerrado_vivo/pages/chat_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ChatCard extends StatefulWidget {
  final Chat chat;

  ChatCard({super.key, required this.chat});

  @override
  State<ChatCard> createState() => _ChatCardState();
}

class _ChatCardState extends State<ChatCard> {
  ChatUser? _otherUser;
  static const _defaultImage = 'assets/images/avatar.png';

  @override
  void initState() {
    super.initState();
    _getOtherUser();
  }

  Future<void> _getOtherUser() async {
    final currentUser = FirebaseAuth.instance.currentUser!.uid;
    final otherUserId = widget.chat.users.firstWhere((user) => user != currentUser);
    final userDocRef = FirebaseFirestore.instance.collection('users').doc(otherUserId);
    final userSnapshot = await userDocRef.get();

    if (userSnapshot.exists) {
      final userData = userSnapshot.data()! as Map<String, dynamic>;
      _otherUser = ChatUser(
        id: userSnapshot.id,
        name: userData['name'],
        email: userData['email'],
        imageUrl: userData['imageUrl'],
      );
      setState(() {});
    }
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


  @override
  Widget build(BuildContext context) {
    if (_otherUser == null) {
      return const SizedBox.shrink(); // Retorna um widget vazio enquanto o _otherUser é nulo
    }

    return Container(
      width: double.infinity,
      height: 100,
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(
            color: Colors.grey,
            width: 1
          )
        )
      ),
      child: TextButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ChatPage(
                chat: widget.chat,
              )
            )
          );  
        },
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.all(10),
              child: _showUserImage(_otherUser!.imageUrl, 80),
            ),
            Text(
              _otherUser!.name,
              style: TextStyle(fontSize: 19),
            )
          ],
        ),
      ),
    );
  }
}
