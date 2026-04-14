import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
                  const Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('hey, Gesi',
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w500)),
                      Text('what are you doing this weekend?',
                          style: TextStyle(
                              fontSize: 13, color: Colors.white54)),
                    ],
                  ),
                  const CircleAvatar(
                    backgroundColor: Color(0xFFFF7E5F),
                    child: Text('G', style: TextStyle(color: Colors.white)),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _sectionLabel('FRIENDS ATTENDING'),
                  _eventCard(context),
                  _sectionLabel('OPEN GROUPS NEAR YOU'),
                  _groupCard(context, 'Paint Night crew', 'Looking for chill people', '3/5', '2 spots left'),
                  _groupCard(context, 'Art + drinks crew', 'First timers welcome', '1/5', '4 spots left'),
                  _sectionLabel('UPCOMING EVENTS'),
                  _upcomingCard(context),
                ],
              ),
            ),
            bottomNav(context, 0),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 16, bottom: 8),
      child: Text(label,
          style: const TextStyle(
              fontSize: 11,
              color: Colors.white30,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w500)),
    );
  }

  Widget _eventCard(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/groups'),
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF241F1F),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pill('Kamloops Art Party'),
            const SizedBox(height: 6),
            const Text('Paint Night — May 17',
                style: TextStyle(fontWeight: FontWeight.w500)),
            const Text('Riverside Venue · 7:00 PM',
                style: TextStyle(fontSize: 12, color: Colors.white54)),
            const SizedBox(height: 10),
            const Text('6 friends going',
                style: TextStyle(fontSize: 12, color: Colors.white38)),
          ],
        ),
      ),
    );
  }

  Widget _groupCard(BuildContext context, String name, String sub, String count, String spots) {
    return GestureDetector(
      onTap: () => context.go('/groups'),
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
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _pill(spots, color: const Color(0xFF1D9E75)),
                  const SizedBox(height: 4),
                  Text(name,
                      style: const TextStyle(fontWeight: FontWeight.w500)),
                  Text(sub,
                      style: const TextStyle(
                          fontSize: 12, color: Colors.white54)),
                ],
              ),
            ),
            Column(
              children: [
                Text(count,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.white38)),
                const Text('members',
                    style: TextStyle(fontSize: 11, color: Colors.white24)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _upcomingCard(BuildContext context) {
    return GestureDetector(
      onTap: () => context.go('/groups'),
      child: Container(
        padding: const EdgeInsets.all(14),
        margin: const EdgeInsets.only(bottom: 12),
        decoration: BoxDecoration(
          color: const Color(0xFF241F1F),
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.white.withOpacity(0.05)),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _pill('May 24', color: Colors.white24),
            const SizedBox(height: 4),
            const Text('Kamloops Art Party — Vol. 12',
                style: TextStyle(fontWeight: FontWeight.w500)),
            const Text('Downtown Cultural Centre · 24 groups forming',
                style: TextStyle(fontSize: 12, color: Colors.white54)),
          ],
        ),
      ),
    );
  }

  Widget _pill(String text, {Color? color}) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
      decoration: BoxDecoration(
        color: (color ?? const Color(0xFFFF7E5F)).withOpacity(0.15),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(text,
          style: TextStyle(
              fontSize: 11, color: color ?? const Color(0xFFFF7E5F))),
    );
  }
}

Widget bottomNav(BuildContext context, int active) {
  final items = [
    {'icon': Icons.home_outlined, 'label': 'Home', 'route': '/home'},
    {'icon': Icons.group_outlined, 'label': 'Groups', 'route': '/groups'},
    {'icon': Icons.chat_bubble_outline, 'label': 'Messages', 'route': '/messages'},
    {'icon': Icons.people_outline, 'label': 'Friends', 'route': '/friends'},
  ];
  return Container(
    decoration: const BoxDecoration(
      color: Color(0xFF241F1F),
      border: Border(top: BorderSide(color: Colors.white10)),
    ),
    child: SafeArea(
      top: false,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(items.length, (i) {
          final item = items[i];
          final isActive = i == active;
          return GestureDetector(
            onTap: () => context.go(item['route'] as String),
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 12),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(item['icon'] as IconData,
                      color: isActive
                          ? const Color(0xFFFF7E5F)
                          : Colors.white38),
                  const SizedBox(height: 4),
                  Text(item['label'] as String,
                      style: TextStyle(
                          fontSize: 10,
                          color: isActive
                              ? const Color(0xFFFF7E5F)
                              : Colors.white38)),
                ],
              ),
            ),
          );
        }),
      ),
    ),
  );
}