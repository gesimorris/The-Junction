import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';
import 'home_screen.dart'; // To access bottomNav

class MapScreen extends StatefulWidget {
  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  // Kamloops Coordinates
  final LatLng _kamloopsCenter = const LatLng(50.6745, -120.3273);
  
  static const Color kPrimary = Color(0xFFFF5C4D);
  static const Color kDark = Color(0xFF1A1A1A);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // THE REAL MAP
          FlutterMap(
            options: MapOptions(
              initialCenter: _kamloopsCenter,
              initialZoom: 13.0,
              interactionOptions: const InteractionOptions(flags: InteractiveFlag.all),
            ),
            children: [
              TileLayer(
                urlTemplate: 'https://tile.openstreetmap.org/{z}/{x}/{y}.png',
                userAgentPackageName: 'com.links.app',
                // To get the "Cream" look, you can use MapBox styles or a ColorFiltered widget
              ),
              MarkerLayer(
                markers: [
                  _buildBusinessMarker(
                    point: const LatLng(50.6761, -120.3408), // Example: Downtown area
                    icon: Icons.pets,
                    color: const Color(0xFF00D2FF),
                    label: 'Cat Cafe',
                  ),
                  _buildBusinessMarker(
                    point: const LatLng(50.6720, -120.3300), 
                    icon: Icons.palette,
                    color: kPrimary,
                    label: 'Art Party',
                  ),
                ],
              ),
            ],
          ),

          // OVERLAY UI
          SafeArea(
            child: Column(
              children: [
                _topSearchBar(),
                _filterChips(),
              ],
            ),
          ),

          // THE "+" ACTION BUTTON
          Positioned(
            bottom: 110,
            right: 20,
            child: FloatingActionButton.extended(
              onPressed: () {
                // Navigate to 'Create Group' Flow
              },
              backgroundColor: kDark,
              elevation: 4,
              icon: const Icon(Icons.add, color: Colors.white),
              label: const Text("Plan Something", 
                style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
            ),
          ),

          // NAVIGATION
          Align(
            alignment: Alignment.bottomCenter,
            child: bottomNav(context, 1), // Map is usually index 1
          ),
        ],
      ),
    );
  }

  Marker _buildBusinessMarker({required LatLng point, required IconData icon, required Color color, required String label}) {
    return Marker(
      point: point,
      width: 80,
      height: 80,
      child: GestureDetector(
        onTap: () {
          // SHOW BUSINESS DETAILS MODAL
          _showBusinessDetails(label);
        },
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(15),
                boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.1), blurRadius: 10)],
              ),
              child: Icon(icon, color: color, size: 24),
            ),
            const SizedBox(height: 4),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
              decoration: BoxDecoration(color: Colors.white.withOpacity(0.9), borderRadius: BorderRadius.circular(8)),
              child: Text(label, style: const TextStyle(fontSize: 10, fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
    );
  }

  void _showBusinessDetails(String name) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        height: 300,
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(32)),
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(name, style: const TextStyle(fontSize: 24, fontWeight: FontWeight.w900)),
            const Text("Open · Closes 8:00 PM", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
            const SizedBox(height: 20),
            const Text("ACTIVE GROUPS", style: TextStyle(fontSize: 12, color: Colors.black26, letterSpacing: 1.2)),
            const SizedBox(height: 10),
            ListTile(
              leading: const CircleAvatar(child: Text("S")),
              title: const Text("Shalom's Table"),
              subtitle: const Text("Looking for 2 more people"),
              trailing: ElevatedButton(onPressed: () {}, child: const Text("Join")),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topSearchBar() {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(30),
          boxShadow: [BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 15)],
        ),
        child: const Row(
          children: [
            Icon(Icons.search, color: kPrimary, size: 20),
            SizedBox(width: 12),
            Text("Search Kamloops spots...", style: TextStyle(color: Colors.black26, fontWeight: FontWeight.w500)),
          ],
        ),
      ),
    );
  }

  Widget _filterChips() {
    final filters = ['Cafes', 'Art', 'Nightlife', 'TRU Campus'];
    return SizedBox(
      height: 35,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        scrollDirection: Axis.horizontal,
        itemCount: filters.length,
        separatorBuilder: (_, __) => const SizedBox(width: 10),
        itemBuilder: (context, i) => Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.black.withOpacity(0.05)),
          ),
          alignment: Alignment.center,
          child: Text(filters[i], style: const TextStyle(fontSize: 12, fontWeight: FontWeight.w800)),
        ),
      ),
    );
  }
}