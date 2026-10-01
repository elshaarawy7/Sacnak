import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sacny/feat/chat/data/chat_models.dart';

class ChatService {
  ChatService({FirebaseFirestore? firestore, FirebaseAuth? auth})
    : _firestore = firestore ?? FirebaseFirestore.instance,
      _auth = auth ?? FirebaseAuth.instance;

  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  Future<ChatConversation> openConversation({
    required String ownerId,
    required String ownerName,
    required String ownerImage,
    required String propertyId,
    required String propertyTitle,
    required String propertyAddress,
    required double propertyPrice,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw StateError('يجب تسجيل الدخول لبدء المحادثة.');
    if (ownerId.isEmpty) {
      throw StateError('بيانات مالك هذا العقار غير مكتملة.');
    }
    if (ownerId == user.uid) {
      throw StateError('لا يمكنك بدء محادثة مع حسابك.');
    }

    final tenantData = await _readProfile(user.uid);
    final ownerData = await _readProfile(ownerId);
    final tenantName = _profileValue(
      tenantData,
      'name',
      user.displayName ?? 'مستأجر',
    );
    final tenantImage = _profileValue(tenantData, 'image', user.photoURL ?? '');
    final resolvedOwnerName = _profileValue(
      ownerData,
      'name',
      ownerName.trim().isNotEmpty ? ownerName.trim() : 'مالك العقار',
    );
    final resolvedOwnerImage = _profileValue(
      ownerData,
      'image',
      ownerImage.trim(),
    );
    final conversationId = '${propertyId}_${user.uid}';
    final conversationRef = _firestore.collection('chats').doc(conversationId);

    final conversationData = <String, dynamic>{
      'ownerId': ownerId,
      'tenantId': user.uid,
      'participantIds': [ownerId, user.uid],
      'ownerName': resolvedOwnerName,
      'ownerImage': resolvedOwnerImage,
      'tenantName': tenantName,
      'tenantImage': tenantImage,
      'propertyId': propertyId,
      'propertyTitle': propertyTitle,
      'propertyAddress': propertyAddress,
      'propertyPrice': propertyPrice,
      'updatedAt': FieldValue.serverTimestamp(),
    };

    final existingConversation = await conversationRef.get();
    if (!existingConversation.exists) {
      conversationData['lastMessage'] = '';
      conversationData['lastMessageAt'] = FieldValue.serverTimestamp();
    }
    await conversationRef.set(conversationData, SetOptions(merge: true));

    return ChatConversation.fromMap(conversationId, {
      ...?existingConversation.data(),
      ...conversationData,
    });
  }

  Stream<List<ChatConversation>> watchOwnerConversations(String ownerId) {
    return _firestore
        .collection('chats')
        .where('participantIds', arrayContains: ownerId)
        .snapshots()
        .map((snapshot) {
          final conversations = snapshot.docs
              .where((doc) {
                final data = doc.data();
                final ownerValue = data['ownerId']?.toString() ?? '';
                final tenantValue = data['tenantId']?.toString() ?? '';
                return ownerValue == ownerId || tenantValue == ownerId;
              })
              .map((doc) => ChatConversation.fromMap(doc.id, doc.data()))
              .toList();

          conversations.sort((first, second) {
            final firstDate = first.lastMessageAt;
            final secondDate = second.lastMessageAt;
            if (firstDate == null) return 1;
            if (secondDate == null) return -1;
            return secondDate.compareTo(firstDate);
          });
          return conversations;
        });
  }

  Stream<List<ChatMessage>> watchMessages(String conversationId) {
    return _firestore
        .collection('chats')
        .doc(conversationId)
        .collection('messages')
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => ChatMessage.fromMap(doc.id, doc.data()))
              .toList(),
        );
  }

  Future<void> sendMessage({
    required ChatConversation conversation,
    required String text,
  }) async {
    final user = _auth.currentUser;
    if (user == null) throw StateError('انتهت جلسة تسجيل الدخول.');
    final cleanText = text.trim();
    if (cleanText.isEmpty) return;
    if (user.uid != conversation.ownerId && user.uid != conversation.tenantId) {
      throw StateError('ليس لديك صلاحية لإرسال رسالة في هذه المحادثة.');
    }

    final chatRef = _firestore.collection('chats').doc(conversation.id);
    final messageRef = chatRef.collection('messages').doc();
    final batch = _firestore.batch();
    batch.set(messageRef, {
      'senderId': user.uid,
      'text': cleanText,
      'createdAt': FieldValue.serverTimestamp(),
    });
    batch.set(chatRef, {
      'lastMessage': cleanText,
      'lastMessageAt': FieldValue.serverTimestamp(),
      'lastSenderId': user.uid,
      'updatedAt': FieldValue.serverTimestamp(),
    }, SetOptions(merge: true));
    await batch.commit();
  }

  Future<Map<String, dynamic>> _readProfile(String uid) async {
    final snapshot = await _firestore.collection('admin_suers').doc(uid).get();
    return snapshot.data() ?? <String, dynamic>{};
  }

  String _profileValue(Map<String, dynamic> data, String key, String fallback) {
    final value = data[key]?.toString().trim();
    return value == null || value.isEmpty ? fallback : value;
  }
}
