import 'package:flutter/material.dart';
import 'package:sacny/feat/chat/data/chat_models.dart';
import 'package:sacny/feat/chat/presentation/widgets/chat_page_body.dart';

class ChatPage extends StatelessWidget {
  const ChatPage({super.key, required this.conversation});

  final ChatConversation conversation;

  static const String routeName = "ChatPage";

  @override
  Widget build(BuildContext context) {
    return Scaffold(body: ChatPageBody(conversation: conversation));
  }
}
