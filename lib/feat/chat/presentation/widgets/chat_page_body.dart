import 'package:flutter/material.dart';
import 'package:sacny/feat/chat/data/chat_models.dart';
import 'package:sacny/feat/chat/presentation/widgets/chat_room_page_body.dart';

class ChatPageBody extends StatelessWidget {
  const ChatPageBody({super.key, required this.conversation});

  final ChatConversation conversation;

  @override
  Widget build(BuildContext context) {
    return ChatRoomPageBody(conversation: conversation);
  }
}
