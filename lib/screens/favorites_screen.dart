import 'package:flutter/material.dart';
import '../data/event_data.dart';
import '../data/favorite_store.dart';
import '../widgets/event_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  Set<String> _ids = {};

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final ids = await FavoriteStore.getFavorites();
    if (mounted) setState(() => _ids = ids);
  }

  @override
  Widget build(BuildContext context) {
    final saved = events.where((event) => _ids.contains(event.id)).toList();
    return Scaffold(
      appBar: AppBar(title: const Text('Favourite Events')),
      body: saved.isEmpty
          ? const Center(child: Text('No favourites yet. Save an event to find it here.'))
          : ListView(
              padding: const EdgeInsets.all(16),
              children: saved.map((event) => EventCard(event: event)).toList(),
            ),
    );
  }
}
