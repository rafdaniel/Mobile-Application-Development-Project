// lib/models/message.dart
class Message {
  final String id;
  final String name;
  final String avatar;
  final String message;
  final String time;
  final bool unread;
  final bool isOnline;
  final String? deviceName;

  Message({
    required this.id,
    required this.name,
    required this.avatar,
    required this.message,
    required this.time,
    required this.unread,
    this.isOnline = false,
    this.deviceName,
  });
}