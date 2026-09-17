import 'package:flutter/material.dart';
import '../models/event.dart';
import '../screens/event_details_screen.dart';

class EventCard extends StatelessWidget {
  final Event event;

  const EventCard({
    super.key,
    required this.event,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 2,
      child: InkWell(
        borderRadius: BorderRadius.circular(12),
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) {
                return EventDetailsScreen(event: event);
              },
            ),
          );
        },
        child: ListTile(
          contentPadding: const EdgeInsets.all(12),

          leading: Container(
            width: 75,
            height: 75,
            decoration: BoxDecoration(
              color: Colors.deepPurple.shade100,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Icon(
              _getIcon(),
              color: Colors.deepPurple,
              size: 35,
            ),
          ),

          title: Text(
            event.title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 17,
            ),
          ),

          subtitle: Padding(
            padding: const EdgeInsets.only(top: 6),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('📅 ${event.date}'),
                const SizedBox(height: 4),
                Text('📍 ${event.location}'),
                const SizedBox(height: 4),
                Text(
                  event.price,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.deepPurple,
                  ),
                ),
              ],
            ),
          ),

          trailing: const Icon(
            Icons.arrow_forward_ios,
            size: 16,
          ),
        ),
      ),
    );
  }

  IconData _getIcon() {
    switch (event.category.toLowerCase()) {
      case 'music':
        return Icons.music_note;
      case 'technology':
        return Icons.computer;
      case 'comedy':
        return Icons.mic;
      case 'sports':
        return Icons.sports_soccer;
      case 'arts':
        return Icons.palette;
      default:
        return Icons.event;
    }
  }
}