import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/chat/data/chat_models.dart';
import 'package:sacny/feat/chat/data/chat_service.dart';

class ChatRoomPageBody extends StatefulWidget {
  const ChatRoomPageBody({super.key, required this.conversation});

  final ChatConversation conversation;

  @override
  State<ChatRoomPageBody> createState() => _ChatRoomPageBodyState();
}

class _ChatRoomPageBodyState extends State<ChatRoomPageBody> {
  final _messageController = TextEditingController();
  final _chatService = ChatService();
  bool _isSending = false;

  @override
  void dispose() {
    _messageController.dispose();
    super.dispose();
  }

  Future<void> _sendMessage() async {
    final text = _messageController.text.trim();
    if (text.isEmpty || _isSending) return;
    setState(() => _isSending = true);
    try {
      await _chatService.sendMessage(
        conversation: widget.conversation,
        text: text,
      );
      if (mounted) _messageController.clear();
    } catch (_) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text(
              'تعذر إرسال الرسالة. تحقق من الاتصال وحاول مرة أخرى.',
            ),
          ),
        );
      }
    } finally {
      if (mounted) setState(() => _isSending = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final currentUserId = FirebaseAuth.instance.currentUser?.uid ?? '';
    final isOwner = currentUserId == widget.conversation.ownerId;
    final contactName = isOwner
        ? widget.conversation.tenantName
        : widget.conversation.ownerName;
    final contactImage = isOwner
        ? widget.conversation.tenantImage
        : widget.conversation.ownerImage;

    return Directionality(
      textDirection: TextDirection.rtl,
      child: ColoredBox(
        color: AppColors.lightBg,
        child: SafeArea(
          child: Column(
            children: [
              _ChatHeader(
                name: contactName,
                image: contactImage,
                address: widget.conversation.propertyAddress,
                onBack: () => Navigator.maybePop(context),
              ),
              _PropertySummary(conversation: widget.conversation),
              Expanded(
                child: StreamBuilder<List<ChatMessage>>(
                  stream: _chatService.watchMessages(widget.conversation.id),
                  builder: (context, snapshot) {
                    if (snapshot.hasError) {
                      return const _ChatState(
                        icon: Icons.wifi_off_rounded,
                        text: 'تعذر تحميل الرسائل. تحقق من إعدادات Firestore.',
                      );
                    }
                    if (snapshot.connectionState == ConnectionState.waiting &&
                        !snapshot.hasData) {
                      return const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.primaryGreen,
                        ),
                      );
                    }
                    final messages = snapshot.data ?? const <ChatMessage>[];
                    if (messages.isEmpty) {
                      return const _ChatState(
                        icon: Icons.waving_hand_outlined,
                        text: 'ابدأ المحادثة برسالة لصاحب العقار',
                      );
                    }
                    return ListView.builder(
                      reverse: true,
                      padding: const EdgeInsets.fromLTRB(16, 16, 16, 20),
                      itemCount: messages.length,
                      itemBuilder: (context, index) {
                        final message = messages[index];
                        return _MessageBubble(
                          message: message,
                          isMine: message.senderId == currentUserId,
                        );
                      },
                    );
                  },
                ),
              ),
              _MessageComposer(
                controller: _messageController,
                isSending: _isSending,
                onSend: _sendMessage,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ChatHeader extends StatelessWidget {
  const _ChatHeader({
    required this.name,
    required this.image,
    required this.address,
    required this.onBack,
  });

  final String name;
  final String image;
  final String address;
  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 8, 12, 12),
      color: AppColors.white,
      child: Row(
        children: [
          IconButton(
            onPressed: onBack,
            tooltip: 'رجوع',
            icon: const Icon(Icons.arrow_forward_rounded),
            color: AppColors.darkText,
          ),
          _ChatAvatar(image: image, name: name, radius: 23),
          const SizedBox(width: 11),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  name,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.darkText,
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                if (address.isNotEmpty) ...[
                  const SizedBox(height: 3),
                  Text(
                    address,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Color(0xFF71807B),
                      fontSize: 12,
                    ),
                  ),
                ],
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PropertySummary extends StatelessWidget {
  const _PropertySummary({required this.conversation});

  final ChatConversation conversation;

  @override
  Widget build(BuildContext context) {
    final price = conversation.propertyPrice > 0
        ? '${conversation.propertyPrice.toStringAsFixed(0)} ر.س / شهريًا'
        : 'تفاصيل العقار';
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 14, 16, 8),
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 12),
      decoration: BoxDecoration(
        color: const Color(0xFFEAF2EF),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: const Color(0xFFD9E7E1)),
      ),
      child: Row(
        children: [
          const Icon(
            Icons.apartment_rounded,
            color: AppColors.primaryGreen,
            size: 21,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  conversation.propertyTitle,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: AppColors.darkText,
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 3),
                Text(
                  price,
                  style: const TextStyle(
                    color: Color(0xFF65736E),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBubble extends StatelessWidget {
  const _MessageBubble({required this.message, required this.isMine});

  final ChatMessage message;
  final bool isMine;

  @override
  Widget build(BuildContext context) {
    final bubbleColor = isMine ? AppColors.primaryGreen : AppColors.white;
    final textColor = isMine ? AppColors.white : AppColors.darkText;
    return Align(
      alignment: isMine ? Alignment.centerRight : Alignment.centerLeft,
      child: Container(
        constraints: BoxConstraints(
          maxWidth: MediaQuery.sizeOf(context).width * 0.78,
        ),
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.fromLTRB(13, 10, 13, 8),
        decoration: BoxDecoration(
          color: bubbleColor,
          borderRadius: BorderRadius.only(
            topLeft: const Radius.circular(16),
            topRight: const Radius.circular(16),
            bottomLeft: Radius.circular(isMine ? 16 : 4),
            bottomRight: Radius.circular(isMine ? 4 : 16),
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              message.text,
              style: TextStyle(color: textColor, fontSize: 14, height: 1.5),
            ),
            const SizedBox(height: 5),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  _formatTime(message.createdAt),
                  style: TextStyle(
                    color: isMine
                        ? Colors.white.withValues(alpha: 0.75)
                        : const Color(0xFF8A9691),
                    fontSize: 10,
                  ),
                ),
                if (isMine) ...[
                  const SizedBox(width: 4),
                  Icon(
                    Icons.done_rounded,
                    color: Colors.white.withValues(alpha: 0.8),
                    size: 14,
                  ),
                ],
              ],
            ),
          ],
        ),
      ),
    );
  }

  String _formatTime(DateTime? dateTime) {
    if (dateTime == null) return '...';
    final hour = dateTime.hour % 12 == 0 ? 12 : dateTime.hour % 12;
    final minute = dateTime.minute.toString().padLeft(2, '0');
    return '$hour:$minute ${dateTime.hour < 12 ? 'ص' : 'م'}';
  }
}

class _MessageComposer extends StatelessWidget {
  const _MessageComposer({
    required this.controller,
    required this.isSending,
    required this.onSend,
  });

  final TextEditingController controller;
  final bool isSending;
  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      decoration: BoxDecoration(
        color: AppColors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 12,
            offset: const Offset(0, -3),
          ),
        ],
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          Expanded(
            child: TextField(
              controller: controller,
              minLines: 1,
              maxLines: 4,
              textDirection: TextDirection.rtl,
              textAlign: TextAlign.right,
              textInputAction: TextInputAction.send,
              onSubmitted: (_) => onSend(),
              decoration: InputDecoration(
                hintText: 'اكتب رسالتك...',
                hintStyle: const TextStyle(
                  color: Color(0xFF9AA5A0),
                  fontSize: 14,
                ),
                filled: true,
                fillColor: const Color(0xFFF3F6F4),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 12,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(24),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(width: 9),
          SizedBox(
            height: 46,
            width: 46,
            child: IconButton.filled(
              onPressed: isSending ? null : onSend,
              tooltip: 'إرسال الرسالة',
              style: IconButton.styleFrom(
                backgroundColor: AppColors.primaryGreen,
                foregroundColor: Colors.white,
              ),
              icon: isSending
                  ? const SizedBox.square(
                      dimension: 18,
                      child: CircularProgressIndicator(
                        strokeWidth: 2,
                        color: Colors.white,
                      ),
                    )
                  : const Icon(Icons.send_rounded, size: 20),
            ),
          ),
        ],
      ),
    );
  }
}

class _ChatAvatar extends StatelessWidget {
  const _ChatAvatar({
    required this.image,
    required this.name,
    required this.radius,
  });

  final String image;
  final String name;
  final double radius;

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return CircleAvatar(
        radius: radius,
        backgroundColor: const Color(0xFFE3F0EC),
        child: Text(
          name.isEmpty ? '?' : name.characters.first,
          style: const TextStyle(
            color: AppColors.primaryGreen,
            fontWeight: FontWeight.w700,
          ),
        ),
      );
    }
    return ClipOval(
      child: Image.network(
        image,
        width: radius * 2,
        height: radius * 2,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) => CircleAvatar(
          radius: radius,
          backgroundColor: const Color(0xFFE3F0EC),
          child: const Icon(
            Icons.person_rounded,
            color: AppColors.primaryGreen,
          ),
        ),
      ),
    );
  }
}

class _ChatState extends StatelessWidget {
  const _ChatState({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, color: const Color(0xFF93A19B), size: 42),
            const SizedBox(height: 12),
            Text(
              text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF71807B), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
