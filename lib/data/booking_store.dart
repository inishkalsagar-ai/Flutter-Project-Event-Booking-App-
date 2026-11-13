import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/booking.dart';

class BookingStore {
  static const String _key = 'event_bookings';

  static Future<List<Booking>> getBookings() async {
    final prefs = await SharedPreferences.getInstance();
    final saved = prefs.getStringList(_key) ?? [];
    return saved.map((item) =>
        Booking.fromJson(jsonDecode(item) as Map<String, dynamic>)).toList();
  }

  static Future<void> addBooking(Booking booking) async {
    final bookings = await getBookings();
    bookings.insert(0, booking);
    await _save(bookings);
  }

  static Future<void> cancelBooking(String id) async {
    final bookings = await getBookings();
    final index = bookings.indexWhere((booking) => booking.id == id);
    if (index == -1) return;
    bookings[index] = bookings[index].copyWith(isCancelled: true);
    await _save(bookings);
  }

  static Future<void> _save(List<Booking> bookings) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList(
      _key, bookings.map((booking) => jsonEncode(booking.toJson())).toList(),
    );
  }
}
