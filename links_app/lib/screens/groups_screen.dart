import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'home_screen.dart';

class GroupsScreen extends StatelessWidget {
  const GroupsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Groups',
                      style: TextStyle(
                          fontSize: 20, fontWeight: FontWeight.w500)),
                  GestureDetector(
                    onTap: () {},
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 14, vertical: 8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFFF7E5F),
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: const Text('+ New',
                          style: TextStyle(
                              fontSize: 13, fontWeight: FontWeight.w500)),
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _groupTile(context, 'Paint Night crew', 'Marcus: see you all there!', 'PA', '7:42 PM', 3),
                  _groupTile(context, 'Art + drinks crew', 'Sofia: anyone need a ride?', 'AK', '6:15 PM', 0),
                  _groupTile(context, 'Vol. 12 squad', 'You: sounds good!', 'VS', 'Yesterday', 0),
                ],
              ),
            ),
            bottomNav(context, 1),
          ],
        ),
      ),
    );
  }

  Widget _groupTile(BuildContext context, String name, String lastMsg, String initials, String time, int unread) {
    return GestureDetector(
      onTap: () => context.go('/chat'),
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF241F1F),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: const Color(0xFFFF7E5F),
              child: Text(initials,
                  style: const TextStyle(fontSize: 13, color: Colors.white)),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(name,
                          style: const TextStyle(fontWeight: FontWeight.w500)),
                      if (unread > 0) ...[
                        const SizedBox(width: 6),
                        Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 6, vertical: 2),
                          decoration: BoxDecoration(
                            color: const Color(0xFFFF7E5F),
                            borderRadius: BorderRadius.circular(10),
                          ),
                          child: Text('$unread',
                              style: const TextStyle(
                                  fontSize: 10, color: Colors.white)),
                        ),
                      ],
                    ],
                  ),
                  Text(lastMsg,
                      style: const TextStyle(
                          fontSize: 12, color: Colors.white54),
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Text(time,
                style:
                    const TextStyle(fontSize: 11, color: Colors.white30)),
          ],
        ),
      ),
    );
  }
}