import 'package:flutter/material.dart';
import '../data/event_data.dart';
import '../models/event.dart';
import '../widgets/event_card.dart';
import '../widgets/favorite_button.dart';
import 'bookings_screen.dart';
import 'favorites_screen.dart';
import 'profile_screen.dart';
import 'event_status_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String _searchText = '';
  String _selectedCategory = 'All';

  final List<String> _categories = [
    'All', 'Music', 'Technology', 'Comedy', 'Sports', 'Arts',
  ];

  List<Event> get _filteredEvents {
    return events.where((event) {
      final matchesSearch = event.title.toLowerCase().contains(_searchText) ||
          event.location.toLowerCase().contains(_searchText) ||
          event.category.toLowerCase().contains(_searchText);
      final matchesCategory = _selectedCategory == 'All' ||
          event.category.toLowerCase() == _selectedCategory.toLowerCase();
      return matchesSearch && matchesCategory;
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      _buildEventPage(),
      _buildEventPage(showExploreTitle: true),
      const BookingsScreen(),
      const ProfileScreen(),
    ];

    return Scaffold(
      body: SafeArea(child: pages[_selectedIndex]),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _selectedIndex,
        onDestinationSelected: (index) => setState(() => _selectedIndex = index),
        destinations: const [
          NavigationDestination(icon: Icon(Icons.home_outlined), selectedIcon: Icon(Icons.home), label: 'Home'),
          NavigationDestination(icon: Icon(Icons.explore_outlined), selectedIcon: Icon(Icons.explore), label: 'Explore'),
          NavigationDestination(icon: Icon(Icons.confirmation_number_outlined), selectedIcon: Icon(Icons.confirmation_number), label: 'Bookings'),
          NavigationDestination(icon: Icon(Icons.person_outline), selectedIcon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
    );
  }

  Widget _buildEventPage({bool showExploreTitle = false}) {
    final filtered = _filteredEvents;
    return Scaffold(
      appBar: AppBar(
        title: Text(showExploreTitle ? 'Explore Events' : 'Event Booking',
            style: const TextStyle(fontWeight: FontWeight.bold)),
        actions: [
          IconButton(
            tooltip: 'Favourite events',
            onPressed: () => Navigator.push(context,
                MaterialPageRoute(builder: (_) => const FavoritesScreen())),
            icon: const Icon(Icons.favorite_border),
          ),
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          Text(
            showExploreTitle ? 'Explore what you love' : 'Find Your Next Event',
            style: const TextStyle(fontSize: 27, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Text('Discover amazing events near you',
              style: TextStyle(fontSize: 16, color: Colors.grey.shade600)),
          const SizedBox(height: 20),
          TextField(
            onChanged: (value) => setState(() => _searchText = value.trim().toLowerCase()),
            decoration: InputDecoration(
              hintText: 'Search by event, category or city...',
              prefixIcon: const Icon(Icons.search),
              suffixIcon: _searchText.isEmpty
                  ? null
                  : IconButton(
                      onPressed: () => setState(() => _searchText = ''),
                      icon: const Icon(Icons.clear),
                    ),
              filled: true,
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(16),
                  borderSide: BorderSide.none),
            ),
          ),
          const SizedBox(height: 24),
          const Text('Categories', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
          const SizedBox(height: 12),
          SizedBox(
            height: 42,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: _categories.map((category) => Padding(
                padding: const EdgeInsets.only(right: 8),
                child: ChoiceChip(
                  label: Text(category),
                  selected: _selectedCategory == category,
                  onSelected: (_) => setState(() => _selectedCategory = category),
                ),
              )).toList(),
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(showExploreTitle ? 'All Events' : 'Upcoming Events',
                  style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
              TextButton(
                onPressed: () => setState(() {
                  _selectedCategory = 'All';
                  _searchText = '';
                }),
                child: const Text('Clear filters'),
              ),
            ],
          ),
          if (filtered.isEmpty)
            const SizedBox(height: 180, child: EventStatus(
              icon: Icons.search_off, title: 'No events found',
              message: 'Try another search or choose a different category.',
            ))
          else
            ...filtered.map((event) => EventCard(event: event)),
        ],
      ),
    );
  }
}
