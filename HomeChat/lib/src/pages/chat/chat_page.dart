import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homechat/src/core/models/user_model.dart';
import 'package:homechat/src/pages/chat/chat_state.dart';
import 'package:homechat/src/pages/chat/chat_vm.dart';
import 'package:homechat/src/pages/chat/widgets/message_receiver.dart';
import 'package:homechat/src/pages/chat/widgets/message_sender.dart';
import 'package:homechat/src/pages/chat/widgets/message_text_field.dart';

class ChatPage extends ConsumerStatefulWidget {
  const ChatPage({super.key});

  @override
  ConsumerState<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends ConsumerState<ChatPage> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final arguments = (ModalRoute.of(context)?.settings.arguments ??
        <String, dynamic>{}) as Map;
    UserModel user = arguments['user'];

    final chatState = ref.watch(chatVmProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          user.name,
          overflow: TextOverflow.visible,
        ),
      ),
      body: Column(
        children: [
          const SizedBox(
            height: 14,
          ),
          Expanded(
            child: chatState.when(
              data: (ChatState messages) {
                return ListView.builder(
                  itemCount: messages.messages.length,
                  itemBuilder: (context, index) {
                    final message = messages.messages[index];
                    if (message.receiverId == user.id) {
                      return MessageReceiver(message: message.text);
                    }
                    return MessageSender(
                      message: message.text,
                    );
                  },
                );
              },
              error: (error, stackTrace) => Center(child: Text('Erro: $error')),
              loading: () => const Center(child: CircularProgressIndicator()),
            ),
          ),
          const MessageTextField(),
        ],
      ),
    );
  }
}
