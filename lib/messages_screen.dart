// lib/messages_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_application_donation/models/message.dart';
import 'package:google_fonts/google_fonts.dart';

class MessagesScreen extends StatefulWidget {
  const MessagesScreen({super.key});

  @override
  State<MessagesScreen> createState() => _MessagesScreenState();
}

class _MessagesScreenState extends State<MessagesScreen>
    with TickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  final TextEditingController _searchController = TextEditingController();
  List<Message> _filteredMessages = [];

  final List<Message> _allMessages = [
    Message(
      id: '1',
      name: 'Liam Carter',
      avatar: 'https://placehold.co/40x40/4CAF50/FFFFFF?text=LC',
      message: 'Hi there! I\'m interested in your old laptop. Is it still available?',
      time: '10m ago',
      unread: true,
      isOnline: true,
      deviceName: 'Dell Laptop',
    ),
    Message(
      id: '2',
      name: 'Sophia Bennett',
      avatar: 'https://placehold.co/40x40/FF9800/FFFFFF?text=SB',
      message: 'I have a few old phones I\'d like to donate. Are you still accepting?',
      time: '2h ago',
      unread: true,
      isOnline: false,
      deviceName: 'Samsung Phone',
    ),
    Message(
      id: '3',
      name: 'Ethan Harper',
      avatar: 'https://placehold.co/40x40/9C27B0/FFFFFF?text=EH',
      message: 'Thanks for your interest! I\'ll get back to you soon.',
      time: '1d ago',
      unread: false,
      isOnline: true,
      deviceName: 'iPad Pro',
    ),
    Message(
      id: '4',
      name: 'Olivia Hayes',
      avatar: 'https://placehold.co/40x40/00BCD4/FFFFFF?text=OH',
      message: 'I\'m looking for a tablet. Do you have any available?',
      time: '2d ago',
      unread: false,
      isOnline: false,
      deviceName: 'Surface Tablet',
    ),
    Message(
      id: '5',
      name: 'Noah Foster',
      avatar: 'https://placehold.co/40x40/3F51B5/FFFFFF?text=NF',
      message: 'I have a desktop computer I\'d like to donate. Are you interested?',
      time: '3d ago',
      unread: false,
      isOnline: true,
      deviceName: 'Gaming PC',
    ),
  ];

  @override
  void initState() {
    super.initState();
    _filteredMessages = _allMessages;
    _searchController.addListener(_filterMessages);
    
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeOut),
    );
    _animationController.forward();
  }

  @override
  void dispose() {
    _animationController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _filterMessages() {
    final query = _searchController.text.toLowerCase();
    setState(() {
      _filteredMessages = _allMessages.where((message) {
        return message.name.toLowerCase().contains(query) ||
            message.message.toLowerCase().contains(query);
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 140,
            floating: false,
            pinned: true,
            backgroundColor: const Color(0xFFF8FAFB),
            elevation: 0,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                'Messages',
                style: GoogleFonts.poppins(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Colors.black87,
                ),
              ),
              centerTitle: false,
              titlePadding: const EdgeInsets.only(left: 16, bottom: 16),
            ),
          ),
          SliverToBoxAdapter(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  _buildStatsRow(),
                  _buildSearchBar(),
                ],
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (context, index) {
                final message = _filteredMessages[index];
                return TweenAnimationBuilder<double>(
                  duration: Duration(milliseconds: 300 + (index * 100)),
                  tween: Tween(begin: 0.0, end: 1.0),
                  builder: (context, value, child) {
                    return Transform.translate(
                      offset: Offset(0, 30 * (1 - value)),
                      child: Opacity(
                        opacity: value,
                        child: _buildMessageCard(message),
                      ),
                    );
                  },
                );
              },
              childCount: _filteredMessages.length,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatsRow() {
    final unreadCount = _allMessages.where((m) => m.unread).length;
    final onlineCount = _allMessages.where((m) => m.isOnline).length;
    
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.teal[400]!, Colors.teal[600]!],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.teal.withOpacity(0.3),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              children: [
                Text(
                  '$unreadCount',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Unread',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          Expanded(
            child: Column(
              children: [
                Text(
                  '$onlineCount',
                  style: GoogleFonts.poppins(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                Text(
                  'Online',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
          Container(
            height: 40,
            width: 1,
            color: Colors.white.withOpacity(0.3),
          ),
          Expanded(
            child: Column(
              children: [
                Icon(
                  Icons.chat_bubble,
                  color: Colors.white,
                  size: 24,
                ),
                Text(
                  'Active',
                  style: GoogleFonts.poppins(
                    fontSize: 12,
                    color: Colors.white.withOpacity(0.9),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      margin: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        controller: _searchController,
        decoration: InputDecoration(
          hintText: 'Search conversations...',
          hintStyle: GoogleFonts.poppins(
            color: Colors.grey[400],
            fontSize: 16,
          ),
          prefixIcon: const Icon(
            Icons.search,
            color: Colors.grey,
            size: 22,
          ),
          filled: true,
          fillColor: Colors.white,
          contentPadding: const EdgeInsets.symmetric(vertical: 16),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(25),
            borderSide: BorderSide.none,
          ),
        ),
      ),
    );
  }

  Widget _buildMessageCard(Message message) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.08),
            spreadRadius: 0,
            blurRadius: 12,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(16),
        child: InkWell(
          borderRadius: BorderRadius.circular(16),
          onTap: () {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    ChatScreen(message: message),
                transitionsBuilder: (context, animation, secondaryAnimation, child) {
                  return SlideTransition(
                    position: animation.drive(
                      Tween(begin: const Offset(1.0, 0.0), end: Offset.zero)
                          .chain(CurveTween(curve: Curves.easeInOut)),
                    ),
                    child: child,
                  );
                },
              ),
            );
          },
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  children: [
                    Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(
                          color: message.unread ? Colors.teal[300]! : Colors.grey[200]!,
                          width: message.unread ? 2 : 1,
                        ),
                      ),
                      child: CircleAvatar(
                        backgroundImage: NetworkImage(message.avatar),
                        radius: 24,
                      ),
                    ),
                    if (message.isOnline)
                      Positioned(
                        bottom: 2,
                        right: 2,
                        child: Container(
                          width: 14,
                          height: 14,
                          decoration: BoxDecoration(
                            color: Colors.green,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                        ),
                      ),
                  ],
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Expanded(
                            child: Text(
                              message.name,
                              style: GoogleFonts.poppins(
                                fontWeight: message.unread ? FontWeight.w600 : FontWeight.w500,
                                fontSize: 16,
                                color: Colors.black87,
                              ),
                            ),
                          ),
                          Text(
                            message.time,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: message.unread ? Colors.teal[400] : Colors.grey[500],
                              fontWeight: message.unread ? FontWeight.w500 : FontWeight.w400,
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      if (message.deviceName != null) ...[
                        Row(
                          children: [
                            Icon(
                              Icons.devices,
                              size: 12,
                              color: Colors.grey[400],
                            ),
                            const SizedBox(width: 4),
                            Text(
                              message.deviceName!,
                              style: GoogleFonts.poppins(
                                fontSize: 11,
                                color: Colors.grey[500],
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                      ],
                      Text(
                        message.message,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          color: message.unread ? Colors.black87 : Colors.grey[600],
                          fontWeight: message.unread ? FontWeight.w500 : FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 8),
                Column(
                  children: [
                    if (message.unread)
                      Container(
                        padding: const EdgeInsets.all(6),
                        decoration: BoxDecoration(
                          color: Colors.teal[400],
                          shape: BoxShape.circle,
                        ),
                        child: Text(
                          '1',
                          style: GoogleFonts.poppins(
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                            color: Colors.white,
                          ),
                        ),
                      ),
                    const SizedBox(height: 8),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 14,
                      color: Colors.grey[400],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// Chat Screen Implementation
class ChatScreen extends StatefulWidget {
  final Message message;

  const ChatScreen({super.key, required this.message});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  List<ChatMessage> _chatMessages = [];

  @override
  void initState() {
    super.initState();
    _initializeChatMessages();
  }

  void _initializeChatMessages() {
    _chatMessages = [
      ChatMessage(
        id: '1',
        text: widget.message.message,
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 10)),
        avatar: widget.message.avatar,
      ),
      ChatMessage(
        id: '2',
        text: 'Hi! Yes, it\'s still available. Would you like to know more details about it?',
        isMe: true,
        timestamp: DateTime.now().subtract(const Duration(minutes: 8)),
      ),
      ChatMessage(
        id: '3',
        text: 'That would be great! What\'s the condition like?',
        isMe: false,
        timestamp: DateTime.now().subtract(const Duration(minutes: 5)),
        avatar: widget.message.avatar,
      ),
    ];
  }

  void _sendMessage() {
    if (_messageController.text.trim().isEmpty) return;

    setState(() {
      _chatMessages.add(ChatMessage(
        id: DateTime.now().millisecondsSinceEpoch.toString(),
        text: _messageController.text.trim(),
        isMe: true,
        timestamp: DateTime.now(),
      ));
    });

    _messageController.clear();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF8FAFB),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Colors.black87),
          onPressed: () => Navigator.pop(context),
        ),
        title: Row(
          children: [
            Stack(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(widget.message.avatar),
                  radius: 18,
                ),
                if (widget.message.isOnline)
                  Positioned(
                    bottom: 0,
                    right: 0,
                    child: Container(
                      width: 12,
                      height: 12,
                      decoration: BoxDecoration(
                        color: Colors.green,
                        shape: BoxShape.circle,
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                    ),
                  ),
              ],
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.message.name,
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black87,
                    ),
                  ),
                  Text(
                    widget.message.isOnline ? 'Online' : 'Last seen ${widget.message.time}',
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: Colors.grey[600],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.phone, color: Colors.teal[400]),
            onPressed: () {},
          ),
          IconButton(
            icon: Icon(Icons.more_vert, color: Colors.grey[600]),
            onPressed: () => _showChatOptions(),
          ),
        ],
      ),
      body: Column(
        children: [
          if (widget.message.deviceName != null)
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              margin: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Colors.teal[50]!, Colors.teal[100]!],
                ),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.teal[200]!),
              ),
              child: Row(
                children: [
                  Icon(Icons.devices, color: Colors.teal[600], size: 20),
                  const SizedBox(width: 8),
                  Text(
                    'Discussion about: ${widget.message.deviceName}',
                    style: GoogleFonts.poppins(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: Colors.teal[700],
                    ),
                  ),
                ],
              ),
            ),
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              itemCount: _chatMessages.length,
              itemBuilder: (context, index) {
                final chatMessage = _chatMessages[index];
                return _buildChatBubble(chatMessage);
              },
            ),
          ),
          _buildMessageInput(),
        ],
      ),
    );
  }

  Widget _buildChatBubble(ChatMessage chatMessage) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      child: Row(
        mainAxisAlignment:
            chatMessage.isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!chatMessage.isMe && chatMessage.avatar != null) ...[
            CircleAvatar(
              backgroundImage: NetworkImage(chatMessage.avatar!),
              radius: 14,
            ),
            const SizedBox(width: 8),
          ],
          Flexible(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: BoxDecoration(
                color: chatMessage.isMe ? Colors.teal[400] : Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: const Radius.circular(20),
                  topRight: const Radius.circular(20),
                  bottomLeft: chatMessage.isMe
                      ? const Radius.circular(20)
                      : const Radius.circular(4),
                  bottomRight: chatMessage.isMe
                      ? const Radius.circular(4)
                      : const Radius.circular(20),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    chatMessage.text,
                    style: GoogleFonts.poppins(
                      fontSize: 14,
                      color: chatMessage.isMe ? Colors.white : Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    _formatTime(chatMessage.timestamp),
                    style: GoogleFonts.poppins(
                      fontSize: 10,
                      color: chatMessage.isMe
                          ? Colors.white.withOpacity(0.8)
                          : Colors.grey[500],
                    ),
                  ),
                ],
              ),
            ),
          ),
          if (chatMessage.isMe) ...[
            const SizedBox(width: 8),
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                color: Colors.teal[100],
                shape: BoxShape.circle,
              ),
              child: Icon(
                Icons.person,
                size: 12,
                color: Colors.teal[600],
              ),
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMessageInput() {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.1),
            blurRadius: 10,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: Container(
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(25),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: TextField(
                controller: _messageController,
                decoration: InputDecoration(
                  hintText: 'Type your message...',
                  hintStyle: GoogleFonts.poppins(color: Colors.grey[500]),
                  border: InputBorder.none,
                  contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16, vertical: 12),
                ),
                onSubmitted: (_) => _sendMessage(),
              ),
            ),
          ),
          const SizedBox(width: 8),
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.teal[400]!, Colors.teal[600]!],
              ),
              shape: BoxShape.circle,
            ),
            child: IconButton(
              icon: const Icon(Icons.send, color: Colors.white),
              onPressed: _sendMessage,
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime timestamp) {
    final now = DateTime.now();
    final difference = now.difference(timestamp);

    if (difference.inMinutes < 1) {
      return 'now';
    } else if (difference.inHours < 1) {
      return '${difference.inMinutes}m ago';
    } else if (difference.inDays < 1) {
      return '${difference.inHours}h ago';
    } else {
      return '${difference.inDays}d ago';
    }
  }

  void _showChatOptions() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: const EdgeInsets.only(top: 12),
              height: 4,
              width: 40,
              decoration: BoxDecoration(
                color: Colors.grey[300],
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),
            _buildOptionTile(Icons.block, 'Block User', Colors.red),
            _buildOptionTile(Icons.report, 'Report', Colors.orange),
            _buildOptionTile(Icons.delete, 'Delete Chat', Colors.red),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  Widget _buildOptionTile(IconData icon, String title, Color color) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(
        title,
        style: GoogleFonts.poppins(fontWeight: FontWeight.w500),
      ),
      onTap: () {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('$title selected'),
            backgroundColor: color,
          ),
        );
      },
    );
  }
}

// Models
class ChatMessage {
  final String id;
  final String text;
  final bool isMe;
  final DateTime timestamp;
  final String? avatar;

  ChatMessage({
    required this.id,
    required this.text,
    required this.isMe,
    required this.timestamp,
    this.avatar,
  });
}