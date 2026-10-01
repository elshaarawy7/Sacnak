import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sacny/core/constant/colors_app.dart';
import 'package:sacny/feat/chat/data/chat_models.dart';
import 'package:sacny/feat/chat/data/chat_service.dart';
import 'package:sacny/feat/chat/presentation/widgets/chat_room_page_body.dart';

class AdminChatsPageBody extends StatelessWidget {
  const AdminChatsPageBody({super.key});

  void _openConversation(BuildContext context, ChatConversation conversation) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      useSafeArea: true,
      backgroundColor: Colors.transparent,
      builder: (sheetContext) {
        return DraggableScrollableSheet(
          initialChildSize: 0.92,
          minChildSize: 0.7,
          maxChildSize: 0.96,
          expand: false,
          builder: (context, scrollController) {
            return Container(
              decoration: const BoxDecoration(
                color: AppColors.lightBg,
                borderRadius: BorderRadius.vertical(top: Radius.circular(22)),
              ),
              child: ClipRRect(
                borderRadius: const BorderRadius.vertical(
                  top: Radius.circular(22),
                ),
                child: ChatRoomPageBody(conversation: conversation),
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final ownerId = FirebaseAuth.instance.currentUser?.uid;
    if (ownerId == null) {
      return const Center(child: Text('سجل الدخول لعرض محادثاتك.'));
    }

    return Directionality(
      textDirection: TextDirection.rtl,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 20, 20, 4),
              child: Text(
                'المحادثات',
                style: TextStyle(
                  color: AppColors.darkText,
                  fontSize: 23,
                  fontWeight: FontWeight.w800,
                ),
              ),
            ),
            const Padding(
              padding: EdgeInsets.fromLTRB(20, 0, 20, 16),
              child: Text(
                'رسائلك مع المهتمين بعقاراتك',
                style: TextStyle(color: Color(0xFF71807B), fontSize: 13),
              ),
            ),
            Expanded(
              child: StreamBuilder<List<ChatConversation>>(
                stream: ChatService().watchOwnerConversations(ownerId),
                builder: (context, snapshot) {
                  if (snapshot.hasError) {
                    return const _InboxState(
                      icon: Icons.wifi_off_rounded,
                      message:
                          'تعذر تحميل المحادثات. تحقق من اتصالك وإعدادات Firestore.',
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

                  final conversations = snapshot.data ?? const [];
                  if (conversations.isEmpty) {
                    return const _InboxState(
                      icon: Icons.forum_outlined,
                      message: 'ستظهر هنا رسائل المستأجرين المهتمين بعقاراتك.',
                    );
                  }

                  return ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 4),
                    itemCount: conversations.length,
                    separatorBuilder: (_, _) => const Divider(
                      height: 1,
                      indent: 82,
                      endIndent: 18,
                      color: Color(0xFFE8ECE9),
                    ),
                    itemBuilder: (context, index) => _ConversationTile(
                      conversation: conversations[index],
                      onTap: () => _openConversation(context, conversations[index]),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ConversationTile extends StatelessWidget {
  const _ConversationTile({required this.conversation, required this.onTap});

  final ChatConversation conversation;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 7),
      leading: _TenantAvatar(
        name: conversation.tenantName,
        image: conversation.tenantImage,
      ),
      title: Text(
        conversation.tenantName,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        style: const TextStyle(
          color: AppColors.darkText,
          fontSize: 15,
          fontWeight: FontWeight.w700,
        ),
      ),
      subtitle: Padding(
        padding: const EdgeInsets.only(top: 5),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              conversation.lastMessage.isEmpty
                  ? 'بدأ محادثة جديدة'
                  : conversation.lastMessage,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(color: Color(0xFF71807B), fontSize: 13),
            ),
            const SizedBox(height: 3),
            Text(
              conversation.propertyTitle,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: const TextStyle(
                color: AppColors.primaryGreen,
                fontSize: 11,
              ),
            ),
          ],
        ),
      ),
      trailing: Text(
        _formatDate(conversation.lastMessageAt),
        style: const TextStyle(color: Color(0xFF87938E), fontSize: 11),
      ),
    );
  }

  String _formatDate(DateTime? dateTime) {
    if (dateTime == null) return '';
    final now = DateTime.now();
    if (dateTime.year == now.year &&
        dateTime.month == now.month &&
        dateTime.day == now.day) {
      return '${dateTime.hour.toString().padLeft(2, '0')}:${dateTime.minute.toString().padLeft(2, '0')}';
    }
    return '${dateTime.day}/${dateTime.month}';
  }
}

class _TenantAvatar extends StatelessWidget {
  const _TenantAvatar({required this.name, required this.image});

  final String name;
  final String image;

  @override
  Widget build(BuildContext context) {
    if (image.isEmpty) {
      return CircleAvatar(
        radius: 27,
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
    return CircleAvatar(
      radius: 27,
      backgroundImage: NetworkImage(image),
      onBackgroundImageError: (_, _) {},
    );
  }
}

class _InboxState extends StatelessWidget {
  const _InboxState({required this.icon, required this.message});

  final IconData icon;
  final String message;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(28),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 48, color: const Color(0xFF93A19B)),
            const SizedBox(height: 14),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Color(0xFF71807B), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
