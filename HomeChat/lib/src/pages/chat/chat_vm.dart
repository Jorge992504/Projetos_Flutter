import 'dart:developer';

import 'package:homechat/src/pages/chat/chat_state.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'chat_vm.g.dart';

@riverpod
class ChatVm extends _$ChatVm {
  @override
  Future<ChatState> build() async {
    try {
      // Aqui você pode inicializar com uma lista vazia de mensagens.
      return ChatState(status: ChatStateStatus.initial, messages: []);
    } catch (e, s) {
      log('Erro: ', error: e, stackTrace: s);
      return ChatState(
        status: ChatStateStatus.error,
        messages: [],
        errorMessage: 'Erro ao carregar chat.',
      );
    }
  }
}
