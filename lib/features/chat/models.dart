import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String messageId;
  final String senderId;
  final String messageText;
  final DateTime timestamp;
  final bool isRead;

  MessageModel({required this.messageId, required this.senderId, required this.messageText, required this.timestamp, required this.isRead});

  factory MessageModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return MessageModel(
      messageId: doc.id,
      senderId: data['senderId'] ?? '',
      messageText: data['messageText'] ?? '',
      timestamp: (data['timestamp'] as Timestamp).toDate(),
      isRead: data['isRead'] ?? false,
    );
  }

}

class ChatModel {
  final String chatId;
  final String? lastMessage;
  final DateTime lastMessageTimestamp;

  ChatModel({
    required this.chatId,
    this.lastMessage,
    required this.lastMessageTimestamp,
  });
  factory ChatModel.fromJson(Map<String, dynamic> json) {
    return ChatModel(
      chatId: json['chatId'] as String,
      // userId: json['userId'] as String,
      lastMessage: json['lastMessage'] as String,
      lastMessageTimestamp: (json['lastMessageTimestamp'] as Timestamp).toDate(),
    );
  }
  factory ChatModel.fromDocument(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return ChatModel(
      chatId: data['chatId'] ?? '',
      lastMessage: data['lastMessage'] ?? '',
      lastMessageTimestamp: (data['lastMessageTimestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
    );
  }
}
