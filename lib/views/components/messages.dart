import 'package:cerrado_vivo/views/components/message_bubble.dart';
import 'package:cerrado_vivo/models/chat.dart';
import 'package:cerrado_vivo/models/chat_message.dart';
import 'package:cerrado_vivo/models/user_app.dart';
import 'package:cerrado_vivo/services/auth/auth_firebase_service.dart';
import 'package:cerrado_vivo/services/chat/chat_service.dart';
import 'package:flutter/material.dart';

class Messages extends StatelessWidget {
  final Chat chat;

  const Messages({super.key, required this.chat});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Stream<List<ChatMessage>>>(
      future: ChatService().messagesStream(chat),
      builder: (ctx, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Erro: ${snapshot.error}'));
        } else {
          final messagesStream = snapshot.data;
          if (messagesStream == null) {
            return const Center(child: Text('Sem dados. Vamos conversar?'));
          }
          return StreamBuilder<UserApp?>(
            stream: AuthFirebaseService().userChanges,
            builder: (context, userSnapshot) {
              if (userSnapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (userSnapshot.hasError) {
                return Center(child: Text('Erro: ${userSnapshot.error}'));
              } else {
                final currentUser = userSnapshot.data;
                return StreamBuilder<List<ChatMessage>>(
                  stream: messagesStream,
                  builder: (context, messagesSnapshot) {
                    if (messagesSnapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (messagesSnapshot.hasError) {
                      return Center(child: Text('Erro: ${messagesSnapshot.error}'));
                    } else {
                      final messages = messagesSnapshot.data ?? [];
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
            },
          );
        }
      },
    );
  }
}
