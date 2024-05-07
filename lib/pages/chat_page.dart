import 'package:cerrado_vivo/components/fetch_messages.dart';
import 'package:cerrado_vivo/components/messages.dart';
import 'package:cerrado_vivo/components/new_message.dart';
import 'package:cerrado_vivo/core/models/chat.dart';
import 'package:cerrado_vivo/core/models/chat_message.dart';
import 'package:cerrado_vivo/core/models/chat_user.dart';
import 'package:cerrado_vivo/core/services/auth/auth_service.dart';
import 'package:cerrado_vivo/core/services/notification/chat_notification_service.dart';
import 'package:cerrado_vivo/pages/login_page.dart';
import 'package:cerrado_vivo/pages/notification_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ChatPage extends StatelessWidget {
  final Chat chat;

  ChatPage({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Chat',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Color(0xFF53AC3C),
        actions: [
          DropdownButtonHideUnderline(
            child: DropdownButton(
              icon: Icon(
                Icons.more_vert,
                color: Theme.of(context).primaryIconTheme.color,
              ),
              items: [
                DropdownMenuItem(
                  value: 'logout',
                  child: Row(
                    children: const [
                      Icon(
                        Icons.exit_to_app,
                        color: Colors.black87,
                      ),
                      SizedBox(width: 10),
                      Text('Sair'),
                    ],
                  ),
                ),
              ],
              onChanged: (value) {
                if (value == 'logout') {
                  AuthService().logout();
                  Navigator.push(context,
                      MaterialPageRoute(builder: ((context) => LoginPage())));
                }
              },
            ),
          ),
          Stack(
            children: [
              IconButton(
                icon: const Icon(
                  Icons.notifications,
                  color: Colors.white,
                ),
                onPressed: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(builder: (ctx) {
                      return const NotificationPage();
                    }),
                  );
                },
              ),
              Positioned(
                top: 5,
                right: 5,
                child: CircleAvatar(
                  maxRadius: 10,
                  backgroundColor: Colors.red.shade800,
                  child: Text(
                    '${Provider.of<ChatNotificationService>(context).itemsCount}',
                    style: const TextStyle(
                      fontSize: 12,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
      body: SafeArea(
        child: Column(
          children:  [
            Expanded(child: Messages(chat: chat)),
            NewMessage(chat: chat,),
          ],
        ),
      ),
    );
  }

  

}
