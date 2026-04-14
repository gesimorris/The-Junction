import 'package:flutter/material.dart';
import 'home_screen.dart';

class FriendsScreen extends StatelessWidget {
  const FriendsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.all(20),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text('Friends',
                    style: TextStyle(
                        fontSize: 20, fontWeight: FontWeight.w500)),
              ),
            ),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  _sectionLabel('REQUESTS'),
                  _requestTile('Jordan Mills', 'Paint Night crew'),
                  _sectionLabel('YOUR FRIENDS'),
                  _friendTile('Marcus Allen', 'Going to Paint Night'),
                  _friendTile('Sofia Ahmed', 'Going to Paint Night'),
                  _friendTile('Priya Nair', 'Vol. 12 squad'),
                ],
              ),
            ),
            bottomNav(context, 3),
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

  Widget _requestTile(String name, String context) {
    return Container(
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
            backgroundColor: const Color(0xFF7F77DD),
            child: Text(name[0],
                style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                Text('from $context',
                    style: const TextStyle(
                        fontSize: 12, color: Colors.white54)),
              ],
            ),
          ),
          Row(
            children: [
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFFF7E5F),
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Accept',
                      style: TextStyle(fontSize: 12, color: Colors.white)),
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: () {},
                child: Container(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.white10,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: const Text('Decline',
                      style:
                          TextStyle(fontSize: 12, color: Colors.white54)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _friendTile(String name, String status) {
    return Container(
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
            backgroundColor: const Color(0xFF1D9E75),
            child: Text(name[0],
                style: const TextStyle(color: Colors.white)),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name,
                    style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(status,
                    style: const TextStyle(
                        fontSize: 12, color: Colors.white54)),
              ],
            ),
          ),
        ],
      ),
    );
  }
}