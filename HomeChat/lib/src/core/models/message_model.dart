class MessageModel {
  final int id;
  final int senderId;
  final int receiverId;
  final String text;

  MessageModel({
    required this.id,
    required this.senderId,
    required this.receiverId,
    required this.text,
  });

  factory MessageModel.fromMap(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'sender_id': int senderId,
        'receiver_id': int receiverId,
        'text': String text,
      } =>
        MessageModel(
          id: id,
          senderId: senderId,
          receiverId: receiverId,
          text: text,
        ),
      _ => throw ArgumentError('Invalid JSON MessageModel'),
    };
  }
}
