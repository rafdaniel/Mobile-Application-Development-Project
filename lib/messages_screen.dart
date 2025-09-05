// lib/messages_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_donation/models/message.dart';
import 'package:google_fonts/google_fonts.dart';

class MessagesScreen extends StatelessWidget {
  const MessagesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Message> messages = [
      Message(
        name: 'Liam Carter',
        avatar: 'https://placehold.co/40x40/4CAF50/FFFFFF?text=LC',
        message: 'Hi there! I\'m interested in your old laptop. Is it still available?',
        time: '10m ago',
        unread: true,
      ),
      Message(
        name: 'Sophia Bennett',
        avatar: 'https://placehold.co/40x40/FF9800/FFFFFF?text=SB',
        message: 'I have a few old phones I\'d like to donate. Are you still accepting?',
        time: '2h ago',
        unread: true,
      ),
      Message(
        name: 'Ethan Harper',
        avatar: 'https://placehold.co/40x40/9C27B0/FFFFFF?text=EH',
        message: 'Thanks for your interest! I\'ll get back to you soon.',
        time: '1d ago',
        unread: false,
      ),
      Message(
        name: 'Olivia Hayes',
        avatar: 'https://placehold.co/40x40/00BCD4/FFFFFF?text=OH',
        message: 'I\'m looking for a tablet. Do you have any available?',
        time: '2d ago',
        unread: false,
      ),
      Message(
        name: 'Noah Foster',
        avatar: 'https://placehold.co/40x40/3F51B5/FFFFFF?text=NF',
        message: 'I have a desktop computer I\'d like to donate. Are you interested?',
        time: '3d ago',
        unread: false,
      ),
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Messages',
          style: GoogleFonts.lato(
            fontWeight: FontWeight.bold,
            fontSize: 24,
            color: Colors.white,
          ),
        ),
        backgroundColor: const Color(0xFF4CAF50),
        centerTitle: true,
        elevation: 0,
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: messages.length,
        itemBuilder: (context, index) {
          final message = messages[index];
          return ListTile(
            leading: CircleAvatar(
              backgroundImage: NetworkImage(message.avatar),
              radius: 20,
            ),
            title: Text(
              message.name,
              style: GoogleFonts.lato(fontWeight: FontWeight.bold),
            ),
            subtitle: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  message.message,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: GoogleFonts.lato(color: Colors.grey[600]),
                ),
                Text(
                  message.time,
                  style: GoogleFonts.lato(color: Colors.grey[500], fontSize: 12),
                ),
              ],
            ),
            trailing: message.unread
                ? Container(
                    width: 10,
                    height: 10,
                    decoration: const BoxDecoration(
                      color: Colors.blue,
                      shape: BoxShape.circle,
                    ),
                  )
                : null,
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Message opened!')),
              );
            },
          );
        },
      ),
    );
  }
}
