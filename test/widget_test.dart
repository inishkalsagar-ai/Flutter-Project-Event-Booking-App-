import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:event_booking_app/main.dart';

void main() {
  testWidgets('Home screen displays event booking content', (tester) async {
    await tester.pumpWidget(const EventBookingApp());
    await tester.pumpAndSettle();

    expect(find.text('Event Booking'), findsOneWidget);
    expect(find.text('Find Your Next Event'), findsOneWidget);
    expect(find.text('Music Festival 2026'), findsOneWidget);
  });

  testWidgets('Search filters events by title', (tester) async {
    await tester.pumpWidget(const EventBookingApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'Comedy');
    await tester.pumpAndSettle();

    expect(find.text('Stand-up Comedy Night'), findsOneWidget);
    expect(find.text('Music Festival 2026'), findsNothing);
  });

  testWidgets('Unknown search shows empty state', (tester) async {
    await tester.pumpWidget(const EventBookingApp());
    await tester.pumpAndSettle();

    await tester.enterText(find.byType(TextField), 'No matching event');
    await tester.pumpAndSettle();

    expect(find.text('No events found'), findsOneWidget);
  });
}
