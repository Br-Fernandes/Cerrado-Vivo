import 'package:cloud_firestore/cloud_firestore.dart';

class ChatMessage {
  final String id;
  final String text;
  final DateTime createdAt;

  final String userId;
  final String userName;
  final String userImageUrl;

  const ChatMessage({
    required this.id,
    required this.text,
    required this.createdAt,
    required this.userId,
    required this.userName,
    required this.userImageUrl,
  });

  static ChatMessage fromFirestore(
    DocumentSnapshot<Map<String, dynamic>> snapshot,
    SnapshotOptions? options,
  ) {
    final data = snapshot.data()!;
    return ChatMessage(
      id: snapshot.id,
      text: data['text'],
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      userId: data['userId'],
      userName: data['userName'],
      userImageUrl: data['userImageUrl'],
    );
  }

  Map<String, dynamic> _toFirestore() {
    return {
      'text': text,
      'createdAt': Timestamp.fromDate(createdAt),
      'userId': userId,
      'userName': userName,
      'userImageUrl': userImageUrl,
    };
  }

  toJson() {
    return {
      'id': id,
      'text': text,
      'createdAt': createdAt.toIso8601String(),
      'userId': userId,
      'userName': userName,
      'userImageUrl': userImageUrl,
    };
  }

  static ChatMessage fromMap(Map<String, dynamic> map) {
    return ChatMessage(
      id: map['id'],
      text: map['text'],
      createdAt: DateTime.parse(map['createdAt']),
      userId: map['userId'],
      userName: map['userName'],
      userImageUrl: map['userImageUrl'],
    );
  }
}


