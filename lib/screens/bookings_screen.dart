import 'package:flutter/material.dart';
import '../data/booking_store.dart';
import '../models/booking.dart';

class BookingsScreen extends StatefulWidget {
  const BookingsScreen({super.key});

  @override
  State<BookingsScreen> createState() => _BookingsScreenState();
}

class _BookingsScreenState extends State<BookingsScreen> {
  late Future<List<Booking>> _bookings;

  @override
  void initState() {
    super.initState();
    _refresh();
  }

  void _refresh() => _bookings = BookingStore.getBookings();

  Future<void> _cancel(Booking booking) async {
    await BookingStore.cancelBooking(booking.id);
    if (!mounted) return;
    setState(_refresh);
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Booking cancelled')),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('My Bookings')),
      body: FutureBuilder<List<Booking>>(
        future: _bookings,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }
          final bookings = snapshot.data ?? [];
          if (bookings.isEmpty) {
            return const Center(child: Text('No bookings yet. Book an event to see it here.'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: bookings.length,
            itemBuilder: (context, index) {
              final booking = bookings[index];
              return Card(
                child: ListTile(
                  leading: Icon(
                    booking.isCancelled ? Icons.event_busy : Icons.confirmation_number,
                    color: booking.isCancelled ? Colors.grey : Colors.deepPurple,
                  ),
                  title: Text(booking.eventTitle),
                  subtitle: Text(
                    '${booking.eventDate}\n${booking.ticketCount} ticket(s) • ₹${booking.totalPrice}\n'
                    '${booking.isCancelled ? 'Cancelled' : 'Confirmed'}',
                  ),
                  isThreeLine: true,
                  trailing: booking.isCancelled
                      ? null
                      : IconButton(
                          tooltip: 'Cancel booking',
                          icon: const Icon(Icons.cancel_outlined),
                          onPressed: () => _cancel(booking),
                        ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
