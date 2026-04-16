import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'home_screen.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  static const Color kBackground = Color(0xFFFDFCF9);
  static const Color kPrimary = Color(0xFFFF5C4D);
  static const Color kDark = Color(0xFF1A1A1A);
  static const Color kAccent = Color(0xFF7F77DD);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                children: [
                  _sectionLabel('REQUESTS'),
                  _requestTile(context, 'Jordan Mills', 'Paint Night crew'),
                  const SizedBox(height: 10),
                  _sectionLabel('YOUR FRIENDS'),
                  _friendTile(context, 'Marcus Allen', 'Going to Paint Night'),
                  _friendTile(context, 'Sofia Ahmed', 'Going to Paint Night'),
                  _friendTile(context, 'Priya Nair', 'Vol. 12 squad'),
                ],
              ),
            ),
            bottomNav(context, 3), // Keep index 3 for Friends
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return const Padding(
      padding: EdgeInsets.fromLTRB(24, 20, 24, 8),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text('Friends',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.w900, color: kDark)),
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(top: 20, bottom: 12),
      child: Text(label,
          style: const TextStyle(
              fontSize: 11,
              color: Colors.black26,
              letterSpacing: 1.5,
              fontWeight: FontWeight.w900)),
    );
  }

  Widget _requestTile(BuildContext context, String name, String from) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 22,
                backgroundColor: kAccent.withOpacity(0.1),
                child: Text(name[0], style: const TextStyle(color: kAccent, fontWeight: FontWeight.w900)),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 15, color: kDark)),
                    Text('invitation from $from', style: const TextStyle(fontSize: 12, color: Colors.black38)),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {},
                  child: const Text('Accept'),
                ),
              ),
              const SizedBox(width: 8),
              Expanded(
                child: OutlinedButton(
                  onPressed: () {},
                  child: const Text('Decline'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _friendTile(BuildContext context, String name, String status) {
    return GestureDetector(
      onTap: () => context.push('/chat'), // Navigates to chat when clicking a friend
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 12),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.05), width: 1)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 24,
              backgroundColor: Colors.black.withOpacity(0.05),
              child: Text(name[0], style: const TextStyle(color: kDark, fontWeight: FontWeight.w700)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16, color: kDark)),
                  Text(status, style: const TextStyle(fontSize: 13, color: Colors.black38)),
                ],
              ),
            ),
            const Icon(Icons.chat_bubble_outline, size: 20, color: Colors.black26),
          ],
        ),
      ),
    );
  }
}