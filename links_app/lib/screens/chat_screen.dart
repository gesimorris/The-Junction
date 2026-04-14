import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final messageController = TextEditingController();
  final messages = [
    {'text': 'hey everyone! excited for paint night', 'mine': false, 'name': 'Marcus'},
    {'text': 'same!! first time going', 'mine': false, 'name': 'Sofia'},
    {'text': 'should we meet outside first?', 'mine': true, 'name': 'You'},
    {'text': 'yes! 6:45 outside the venue?', 'mine': false, 'name': 'Marcus'},
    {'text': 'see you all there!', 'mine': false, 'name': 'Marcus'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                children: [
                  GestureDetector(
                    onTap: () => context.go('/groups'),
                    child: const Icon(Icons.arrow_back_ios,
                        size: 20, color: Colors.white54),
                  ),
                  const SizedBox(width: 12),
                  const CircleAvatar(
                    backgroundColor: Color(0xFFFF7E5F),
                    radius: 18,
                    child: Text('PA',
                        style: TextStyle(fontSize: 12, color: Colors.white)),
                  ),
                  const SizedBox(width: 10),
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Paint Night crew',
                          style: TextStyle(fontWeight: FontWeight.w500)),
                      Text('3 members · Paint Night May 17',
                          style: TextStyle(
                              fontSize: 11, color: Colors.white38)),
                    ],
                  ),
                ],
              ),
            ),
            const Divider(color: Colors.white10, height: 1),
            Expanded(
              child: ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: messages.length,
                itemBuilder: (context, i) {
                  final msg = messages[i];
                  final isMine = msg['mine'] as bool;
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      mainAxisAlignment: isMine
                          ? MainAxisAlignment.end
                          : MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        if (!isMine) ...[
                          CircleAvatar(
                            radius: 14,
                            backgroundColor: const Color(0xFF1D9E75),
                            child: Text(
                                (msg['name'] as String)[0],
                                style: const TextStyle(
                                    fontSize: 11, color: Colors.white)),
                          ),
                          const SizedBox(width: 8),
                        ],
                        Container(
                          constraints: const BoxConstraints(maxWidth: 220),
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          decoration: BoxDecoration(
                            color: isMine
                                ? const Color(0xFFFF7E5F)
                                : const Color(0xFF241F1F),
                            borderRadius: BorderRadius.circular(18),
                          ),
                          child: Text(msg['text'] as String,
                              style: TextStyle(
                                  fontSize: 13,
                                  color: isMine
                                      ? Colors.white
                                      : Colors.white70)),
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
                color: Color(0xFF241F1F),
                border: Border(top: BorderSide(color: Colors.white10)),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: messageController,
                      decoration: InputDecoration(
                        hintText: 'message...',
                        contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16, vertical: 10),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(20),
                          borderSide: BorderSide.none,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.08),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  CircleAvatar(
                    backgroundColor: const Color(0xFFFF7E5F),
                    child: IconButton(
                      icon: const Icon(Icons.send, size: 16, color: Colors.white),
                      onPressed: () {},
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