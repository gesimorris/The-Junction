import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final List<Map<String, dynamic>> messages = [
    {'text': 'hey everyone! excited for paint night', 'mine': false, 'name': 'Marcus'},
    {'text': 'same!! first time going', 'mine': false, 'name': 'Sofia'},
    {'text': 'should we meet outside first?', 'mine': true, 'name': 'You'},
    {'text': 'yes! 6:45 outside the venue?', 'mine': false, 'name': 'Marcus'},
    {'text': 'see you all there!', 'mine': false, 'name': 'Marcus'},
  ];

  void _sendMessage() {
    final text = messageController.text.trim();
    if (text.isEmpty) return;
    setState(() {
      messages.add({'text': text, 'mine': true, 'name': 'You'});
      messageController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              decoration: const BoxDecoration(
                border: Border(bottom: BorderSide(color: Colors.white10, width: 0.5)),
              ),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.go('/groups'),
                    child: const Icon(Icons.arrow_back,
                        size: 22, color: Colors.white54),
                  ),
                  const SizedBox(width: 14),
                  const CircleAvatar(
                    radius: 18,
                    backgroundColor: Color(0xFF1A1A1A),
                    child: Text('PA',
                        style: TextStyle(
                            fontSize: 11,
                            color: Color(0xFFFF7E5F),
                            fontWeight: FontWeight.w600)),
                  ),
                  const SizedBox(width: 12),
                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Paint Night crew',
                            style: TextStyle(
                                fontWeight: FontWeight.w600, fontSize: 15)),
                        Text('3 members · May 17',
                            style: TextStyle(
                                fontSize: 11, color: Colors.white38)),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, i) {
                  final msg = messages[i];
                  final isMine = msg['mine'] as bool;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 14),
                    child: Row(
                      mainAxisAlignment: isMine
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!isMine) ...[
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: const Color(0xFF1A1A1A),
                            child: Text(
                                (msg['name'] as String)[0],
                                style: const TextStyle(
                                    fontSize: 11,
                                    color: Color(0xFFFF7E5F))),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Container(
                          constraints: const BoxConstraints(maxWidth: 230),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: isMine
                                ? const Color(0xFFFF7E5F)
                                : const Color(0xFF0F0F0F),
                            borderRadius: BorderRadius.only(
                              topLeft: const Radius.circular(18),
                              topRight: const Radius.circular(18),
                              bottomLeft: Radius.circular(isMine ? 18 : 4),
                              bottomRight: Radius.circular(isMine ? 4 : 18),
                            ),
                            border: isMine
                                ? null
                                : Border.all(color: Colors.white10, width: 0.5),
                          ),
                          child: Text(msg['text'] as String,
                              style: TextStyle(
                                  fontSize: 14,
                                  color: isMine
                                      ? Colors.white
                                      : Colors.white70,
                                  height: 1.4)),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              decoration: const BoxDecoration(
                border: Border(top: BorderSide(color: Colors.white10, width: 0.5)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                      decoration: InputDecoration(
                        hintText: 'message...',
                        hintStyle: const TextStyle(color: Colors.white24),
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        filled: true,
                        fillColor: const Color(0xFF0F0F0F),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: const BorderSide(color: Colors.white10, width: 0.5),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: const BorderSide(color: Colors.white10, width: 0.5),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: const BorderSide(color: Colors.white24, width: 0.5),
                        ),
                      ),
                      onSubmitted: (_) => _sendMessage(),
                    ),
                  ),
                  const SizedBox(width: 10),
                  GestureDetector(
                    onTap: _sendMessage,
                    child: Container(
                      width: 40,
                      height: 40,
                      decoration: const BoxDecoration(
                        color: Color(0xFFFF7E5F),
                        shape: BoxShape.circle,
                      ),
                      child: const Icon(Icons.arrow_upward,
                          size: 18, color: Colors.white),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}