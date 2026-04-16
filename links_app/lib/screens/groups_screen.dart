import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'home_screen.dart'; // To access the same bottomNav

class GroupsScreen extends StatefulWidget {
  const GroupsScreen({super.key});

  @override
  State<GroupsScreen> createState() => _GroupsScreenState();
}

class _GroupsScreenState extends State<GroupsScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  // Consistency with HomeScreen colors
  static const Color kBackground = Color(0xFFFDFCF9); 
  static const Color kPrimary = Color(0xFFFF5C4D);    
  static const Color kDark = Color(0xFF1A1A1A);       

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: SafeArea(
        child: Column(
          children: [
            _header(),
            _tabBar(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _myGroupsTab(),     // Tab 1: Joined & Created
                  _discoverGroupsTab(), // Tab 2: Open groups looking for buddies
                ],
              ),
            ),
            bottomNav(context, 1),
          ],
        ),
      ),
    );
  }

  Widget _header() {
    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 20, 24, 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text('Groups',
              style: TextStyle(
                  fontSize: 28, fontWeight: FontWeight.w900, color: kDark)),
          GestureDetector(
            onTap: () {
              // Open group creation modal
            },
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
              decoration: BoxDecoration(
                color: kPrimary,
                borderRadius: BorderRadius.circular(24),
                boxShadow: [BoxShadow(color: kPrimary.withOpacity(0.3), blurRadius: 10)],
              ),
              child: const Row(
                children: [
                  Icon(Icons.add, color: Colors.white, size: 18),
                  SizedBox(width: 4),
                  Text('New',
                      style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.white)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _tabBar() {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 24, vertical: 10),
      height: 45,
      decoration: BoxDecoration(
        color: Colors.black.withOpacity(0.05),
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          color: Colors.white,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 5)],
        ),
        labelColor: kPrimary,
        unselectedLabelColor: Colors.black38,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        tabs: const [
          Tab(text: 'MY CHATS'),
          Tab(text: 'DISCOVER'),
        ],
      ),
    );
  }

  Widget _myGroupsTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        _groupTile(context, 'Paint Night crew', 'Marcus: See you there!', 'P', '7:42 PM', 3),
        _groupTile(context, 'Art + drinks crew', 'Sofia: Need a ride?', 'A', '6:15 PM', 0),
        _groupTile(context, 'Cat Cafe Buddies', 'You: The orange one is cute', 'C', 'Yesterday', 0),
      ],
    );
  }

  Widget _discoverGroupsTab() {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      children: [
        _discoverCard('Kamloops Art Party', 'Looking for 2 more!', '🎨', kPrimary),
        _discoverCard('Brew It Coffee', 'Anyone want to study?', '☕', const Color(0xFF7F77DD)),
      ],
    );
  }

  Widget _groupTile(BuildContext context, String name, String lastMsg,
      String initials, String time, int unread) {
    return GestureDetector(
      onTap: () => context.go('/chat'),
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 16),
        decoration: BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black.withOpacity(0.05), width: 1)),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 26,
              backgroundColor: kPrimary.withOpacity(0.1),
              child: Text(initials,
                  style: const TextStyle(
                      fontSize: 18,
                      color: kPrimary,
                      fontWeight: FontWeight.w900)),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(name,
                      style: const TextStyle(
                          fontWeight: FontWeight.w800, fontSize: 16, color: kDark)),
                  const SizedBox(height: 4),
                  Text(lastMsg,
                      style: const TextStyle(
                          fontSize: 14, color: Colors.black38),
                      overflow: TextOverflow.ellipsis),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(time,
                    style: const TextStyle(fontSize: 11, color: Colors.black26)),
                const SizedBox(height: 6),
                if (unread > 0)
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: kPrimary,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Text('$unread',
                        style: const TextStyle(
                            fontSize: 10, color: Colors.white, fontWeight: FontWeight.bold)),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _discoverCard(String title, String subtitle, String icon, Color color) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Row(
        children: [
          Text(icon, style: const TextStyle(fontSize: 30)),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w800, fontSize: 16)),
                Text(subtitle, style: const TextStyle(color: Colors.black38, fontSize: 13)),
              ],
            ),
          ),
          ElevatedButton(
            onPressed: () {},
            style: ElevatedButton.styleFrom(
              backgroundColor: color.withOpacity(0.1),
              foregroundColor: color,
              elevation: 0,
              padding: const EdgeInsets.symmetric(horizontal: 16),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
            ),
            child: const Text('Join', style: TextStyle(fontWeight: FontWeight.bold)),
          ),
        ],
      ),
    );
  }
}