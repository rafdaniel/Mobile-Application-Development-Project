// lib/models/message.dart
class Message {
  final String name;
  final String avatar;
  final String message;
  final String time;
  final bool unread;

  Message({
    required this.name,
    required this.avatar,
    required this.message,
    required this.time,
    required this.unread,
  });
}