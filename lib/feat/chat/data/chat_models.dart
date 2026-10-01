import 'package:cloud_firestore/cloud_firestore.dart';

class ChatConversation {
  const ChatConversation({
    required this.id,
    required this.ownerId,
    required this.tenantId,
    required this.ownerName,
    required this.ownerImage,
    required this.tenantName,
    required this.tenantImage,
    required this.propertyId,
    required this.propertyTitle,
    required this.propertyAddress,
    required this.propertyPrice,
    required this.lastMessage,
    this.lastMessageAt,
  });

  final String id;
  final String ownerId;
  final String tenantId;
  final String ownerName;
  final String ownerImage;
  final String tenantName;
  final String tenantImage;
  final String propertyId;
  final String propertyTitle;
  final String propertyAddress;
  final double propertyPrice;
  final String lastMessage;
  final DateTime? lastMessageAt;

  factory ChatConversation.fromMap(String id, Map<String, dynamic> data) {
    final rawPrice = data['propertyPrice'];
    final rawDate = data['lastMessageAt'];

    return ChatConversation(
      id: id,
      ownerId: data['ownerId']?.toString() ?? '',
      tenantId: data['tenantId']?.toString() ?? '',
      ownerName: data['ownerName']?.toString() ?? 'مالك العقار',
      ownerImage: data['ownerImage']?.toString() ?? '',
      tenantName: data['tenantName']?.toString() ?? 'مستأجر',
      tenantImage: data['tenantImage']?.toString() ?? '',
      propertyId: data['propertyId']?.toString() ?? '',
      propertyTitle: data['propertyTitle']?.toString() ?? 'العقار',
      propertyAddress: data['propertyAddress']?.toString() ?? '',
      propertyPrice: rawPrice is num ? rawPrice.toDouble() : 0,
      lastMessage: data['lastMessage']?.toString() ?? '',
      lastMessageAt: rawDate is Timestamp ? rawDate.toDate() : null,
    );
  }
}

class ChatMessage {
  const ChatMessage({
    required this.id,
    required this.senderId,
    required this.text,
    this.createdAt,
  });

  final String id;
  final String senderId;
  final String text;
  final DateTime? createdAt;

  factory ChatMessage.fromMap(String id, Map<String, dynamic> data) {
    final rawDate = data['createdAt'];
    return ChatMessage(
      id: id,
      senderId: data['senderId']?.toString() ?? '',
      text: data['text']?.toString() ?? '',
      createdAt: rawDate is Timestamp ? rawDate.toDate() : null,
    );
  }
}
