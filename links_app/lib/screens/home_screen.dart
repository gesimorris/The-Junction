import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const Color kBackground = Color(0xFFFDFCF9); 
  static const Color kPrimary = Color(0xFFFF5C4D);    
  static const Color kSecondary = Color(0xFF00D2FF);  
  static const Color kDark = Color(0xFF1A1A1A);       

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: kBackground,
      body: Stack(
        children: [
          _mapLayer(),
          _topOverlay(context),
          _draggableEventSheet(context),
        ],
      ),
      bottomNavigationBar: bottomNav(context, 0),
    );
  }

  // Functional Mini-Map Background
  Widget _mapLayer() {
    final LatLng truCenter = LatLng(50.6712, -120.3638); 

    return FlutterMap(
      options: MapOptions(
        initialCenter: truCenter,
        initialZoom: 14.0,
        // Set to none so users don't accidentally pan the background while scrolling
        interactionOptions: const InteractionOptions(flags: InteractiveFlag.none),
      ),
      children: [
        TileLayer(
          urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
          userAgentPackageName: 'com.links.app',
        ),
        MarkerLayer(
          markers: [
            _buildMapMarker(LatLng(50.6761, -120.3408), Icons.pets, kSecondary),
            _buildMapMarker(LatLng(50.6720, -120.3300), Icons.palette, kPrimary),
          ],
        ),
      ],
    );
  }

  Marker _buildMapMarker(LatLng point, IconData icon, Color color) {
    return Marker(
      point: point,
      width: 45,
      height: 45,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 8)],
        ),
        child: Icon(icon, color: color, size: 20),
      ),
    );
  }

  Widget _topOverlay(BuildContext context) {
    // This boolean will be driven by your Riverpod AuthState later
    bool isUserLoggedIn = false; 

    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15)],
                ),
                child: const Row(
                  children: [
                    Icon(Icons.search, size: 20, color: Colors.black26),
                    SizedBox(width: 10),
                    Text('Find buddies...', style: TextStyle(color: Colors.black26, fontSize: 14)),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 12),
            
            // Toggle between Sign Up (Guest) and Profile+Add (Member)
            isUserLoggedIn 
              ? _memberActions(context) 
              : _guestActions(context),
          ],
        ),
      ),
    );
  }

  // Shown for Guests: High-energy Sign Up button
  Widget _guestActions(BuildContext context) {
    return GestureDetector(
      onTap: () => context.push('/home/register'),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
        decoration: BoxDecoration(
          color: kPrimary,
          borderRadius: BorderRadius.circular(25),
          boxShadow: [
            BoxShadow(
              color: kPrimary.withOpacity(0.3), 
              blurRadius: 12, 
              offset: const Offset(0, 4)
            )
          ],
        ),
        child: const Text(
          'Sign Up',
          style: TextStyle(
            color: Colors.white, 
            fontWeight: FontWeight.w900, 
            fontSize: 13
          ),
        ),
      ),
    );
  }

  // Shown for Members: Profile Avatar + Floating Create Button
  Widget _memberActions(BuildContext context) {
    return Column(
      children: [
        const CircleAvatar(
          radius: 24, 
          backgroundColor: kDark, 
          child: Text('G', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold))
        ),
        const SizedBox(height: 8),
        GestureDetector(
          onTap: () {
            // Logic to open Create Group modal
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: kPrimary,
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: kPrimary.withOpacity(0.4), 
                  blurRadius: 8, 
                  offset: const Offset(0, 4)
                )
              ],
            ),
            child: const Icon(Icons.add, color: Colors.white, size: 20),
          ),
        ),
      ],
    );
  }

  Widget _draggableEventSheet(BuildContext context) {
    return DraggableScrollableSheet(
      initialChildSize: 0.35,
      minChildSize: 0.15,
      maxChildSize: 0.9,
      builder: (context, scrollController) {
        return Container(
          decoration: const BoxDecoration(
            color: kBackground,
            borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
            boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 20)],
          ),
          child: ListView(
            controller: scrollController,
            padding: const EdgeInsets.all(24),
            children: [
              Center(
                child: Container(
                  width: 45, 
                  height: 6, 
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.05), 
                    borderRadius: BorderRadius.circular(10)
                  )
                )
              ),
              const SizedBox(height: 25),
              const Text(
                'HAPPENING SOON', 
                style: TextStyle(
                  fontSize: 11, 
                  fontWeight: FontWeight.w900, 
                  letterSpacing: 1.5, 
                  color: Colors.black26
                )
              ),
              const SizedBox(height: 15),
              _buddyCard('Cat Cafe', 'Gesi', 'Latte & Cats?', '2 spots left', kSecondary),
              _buddyCard('Art Party', 'Shalom', 'Painting crew!', '4 spots left', kPrimary),
            ],
          ),
        );
      },
    );
  }

  Widget _buddyCard(String venue, String host, String desc, String spots, Color accent) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(28),
        boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10)],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(venue, style: TextStyle(color: accent, fontWeight: FontWeight.w900, fontSize: 16)),
              Text(spots, style: TextStyle(color: accent, fontSize: 11, fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 8),
          Text(desc, style: const TextStyle(fontSize: 14, color: kDark, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}

Widget bottomNav(BuildContext context, int active) {
  final items = [
    {'icon': Icons.explore_outlined, 'label': 'Explore', 'route': '/home'},
    {'icon': Icons.map_outlined, 'label': 'Map', 'route': '/map'},
    {'icon': Icons.group_outlined, 'label': 'Groups', 'route': '/groups'},
    {'icon': Icons.people_outline, 'label': 'Friends', 'route': '/friends'},
  ];

  return Container(
    decoration: const BoxDecoration(
      color: Colors.white,
      border: Border(top: BorderSide(color: Colors.black12, width: 0.5)),
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
                      size: 24,
                      color: isActive ? const Color(0xFFFF5C4D) : Colors.black26),
                  const SizedBox(height: 4),
                  Text(item['label'] as String,
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: isActive ? FontWeight.bold : FontWeight.normal,
                          color: isActive ? const Color(0xFFFF5C4D) : Colors.black26)),
                ],
              ),
            ),
          );
        }),
      ),
    ),
  );
}