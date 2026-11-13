# Event Booking App

A Flutter application for discovering events, viewing event details, booking tickets and managing saved events.

## Features

- Browse upcoming events with sample event data.
- Search events by title, category or city.
- Filter events by category.
- View event details and ticket prices.
- Book 1–10 tickets with name and email validation.
- Calculate the total ticket amount automatically.
- View a booking confirmation.
- Save bookings locally and view booking history.
- Cancel a booking.
- Add events to favourites and view saved events.
- Navigate between Home, Explore, Bookings and Profile.
- Switch between light and dark themes.

## Built With

- Flutter
- Dart
- Material 3
- Shared Preferences for local device storage

## Getting Started

1. Install Flutter and set up an emulator or connect a device.
2. Clone this repository:

   ```bash
   git clone https://github.com/inishkalsagar-ai/Flutter-Project-Event-Booking-App-.git
   cd Flutter-Project-Event-Booking-App-
   ```

3. Install dependencies:

   ```bash
   flutter pub get
   ```

4. Run the application:

   ```bash
   flutter run
   ```

## Run Tests

```bash
flutter analyze
flutter test
```

## Project Structure

```text
lib/
  data/       Local event data and storage helpers
  models/     Event and booking models
  screens/    Home, details, booking, profile and settings screens
  widgets/    Reusable event and favourite widgets
  main.dart   Application entry point
```

## Storage Note

Bookings and favourite event IDs are saved on the device using Shared Preferences. This project is a learning/demo application; it does not connect to a payment gateway or an online booking server.

## Future Improvements

- User authentication
- Cloud database and account synchronisation
- Real payment gateway integration
- Live event listings and seat availability

## License

This project is created for educational and portfolio purposes.
