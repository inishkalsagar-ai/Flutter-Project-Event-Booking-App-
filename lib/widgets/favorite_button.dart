import 'package:flutter/material.dart';
import '../data/favorite_store.dart';

class FavoriteButton extends StatefulWidget {
  final String eventId;

  const FavoriteButton({super.key, required this.eventId});

  @override
  State<FavoriteButton> createState() => _FavoriteButtonState();
}

class _FavoriteButtonState extends State<FavoriteButton> {
  bool _isFavorite = false;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final ids = await FavoriteStore.getFavorites();
    if (mounted) setState(() => _isFavorite = ids.contains(widget.eventId));
  }

  Future<void> _toggle() async {
    await FavoriteStore.toggleFavorite(widget.eventId);
    if (mounted) setState(() => _isFavorite = !_isFavorite);
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      tooltip: _isFavorite ? 'Remove from favourites' : 'Add to favourites',
      onPressed: _toggle,
      icon: Icon(_isFavorite ? Icons.favorite : Icons.favorite_border,
          color: _isFavorite ? Colors.red : null),
    );
  }
}
