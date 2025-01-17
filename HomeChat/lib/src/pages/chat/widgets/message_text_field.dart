import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:homechat/src/pages/chat/chat_vm.dart';

class MessageTextField extends ConsumerStatefulWidget {
  const MessageTextField({
    super.key,
  });

  @override
  ConsumerState<MessageTextField> createState() => _MessageTextFieldState();
}

class _MessageTextFieldState extends ConsumerState<MessageTextField> {
  String message = '';
  final messageEC = TextEditingController();

  @override
  void dispose() {
    messageEC.dispose();
    super.dispose();
  }

  void _sendMessage() async {
    final messageText = messageEC.text.trim();

    if (messageText.isNotEmpty) {
      final chatVm = ref.read(chatVmProvider.notifier);

      // Aqui você deve substituir pelos IDs corretos do remetente e do destinatário
      const senderId = 1; // Exemplo: ID do usuário atual
      const receiverId = 2; // Exemplo: ID do destinatário

      // Limpa o campo de texto após o envio
      messageEC.clear();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color.fromARGB(255, 234, 234, 234),
      padding: const EdgeInsets.symmetric(
        vertical: 10,
        horizontal: 5,
      ),
      child: Row(
        children: [
          Expanded(
            child: TextField(
              controller: messageEC,
              maxLines: 1,
              onChanged: (message) {
                message = message;
              },
              // onSubmitted: (_) => _sendMessage(),
            ),
          ),
          IconButton(
            onPressed: _sendMessage,
            icon: const Icon(Icons.send),
          ),
        ],
      ),
    );
  }
}
