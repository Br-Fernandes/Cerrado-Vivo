import 'package:cerrado_vivo/components/message_bubble.dart';
import 'package:cerrado_vivo/core/models/chat_message.dart';
import 'package:cerrado_vivo/core/models/chat_user.dart';
import 'package:cerrado_vivo/core/services/auth/auth_firebase_service.dart';
import 'package:flutter/material.dart';

class FetchMessages extends StatelessWidget {
  List<ChatMessage> messages;

  FetchMessages({super.key, required this.messages});



  @override
  Widget build(BuildContext context) {
    return StreamBuilder<ChatUser?>(
      stream: AuthFirebaseService().userChanges,
      builder: (context, userSnapshot) {
        if (userSnapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          final currentUser = userSnapshot.data;
          return ListView.builder(
            reverse: true,
            itemCount: messages.length,
            itemBuilder: (ctx, i) => MessageBubble(
              key: ValueKey(messages[i].id),
              message: messages[i],
              belongsToCurrentUser: currentUser?.id == messages[i].userId,
            ),
          );
        }
      },
    );
  }
  
}