import 'package:cerrado_vivo/models/chat_message.dart';
import 'package:cerrado_vivo/modelview/components/message_bubble_view_model.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class MessageBubble extends StatelessWidget {
  final ChatMessage message;
  final bool belongsToCurrentUser;

  const MessageBubble({
    required this.message,
    required this.belongsToCurrentUser,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => MessageBubbleViewModel(),
      child: Consumer<MessageBubbleViewModel>(
        builder: (context, viewModel, child) {
          return Stack(
            children: [
              Align(
                alignment: belongsToCurrentUser
                    ? Alignment.topRight
                    : Alignment.topLeft,
                child: Container(
                  decoration: BoxDecoration(
                    color: belongsToCurrentUser
                        ? Colors.grey.shade300
                        : Theme.of(context).primaryColor,
                    borderRadius: BorderRadius.only(
                      topLeft: const Radius.circular(12),
                      topRight: const Radius.circular(12),
                      bottomLeft: belongsToCurrentUser
                          ? const Radius.circular(12)
                          : const Radius.circular(0),
                      bottomRight: belongsToCurrentUser
                          ? const Radius.circular(0)
                          : const Radius.circular(12),
                    ),
                  ),
                  width: 180,
                  padding: const EdgeInsets.symmetric(
                    vertical: 10,
                    horizontal: 16,
                  ),
                  margin: const EdgeInsets.symmetric(vertical: 15, horizontal: 8),
                  child: Column(
                    crossAxisAlignment: belongsToCurrentUser
                        ? CrossAxisAlignment.end
                        : CrossAxisAlignment.start,
                    children: [
                      Text(
                        message.userName,
                        style: TextStyle(
                          color: belongsToCurrentUser ? Colors.black : Colors.white,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Text(
                        message.text,
                        textAlign: belongsToCurrentUser
                            ? TextAlign.right
                            : TextAlign.left,
                        style: TextStyle(
                          color: belongsToCurrentUser ? Colors.black : Colors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                top: 0,
                left: belongsToCurrentUser ? null : 165,
                right: belongsToCurrentUser ? 165 : null,
                child: CircleAvatar(
                  backgroundImage: viewModel.getImageProvider(message.userImageUrl),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
