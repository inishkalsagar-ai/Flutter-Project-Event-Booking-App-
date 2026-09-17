import 'package:flutter_test/flutter_test.dart';
import 'package:event_booking_app/main.dart';

void main() {
  testWidgets('Event Booking App loads', (WidgetTester tester) async {
    await tester.pumpWidget(const EventBookingApp());

    expect(find.text('Event Booking'), findsOneWidget);
    expect(find.text('Find Your Next Event'), findsOneWidget);
  });
}