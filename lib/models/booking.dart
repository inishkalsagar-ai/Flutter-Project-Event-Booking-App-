class Booking {
  final String id;
  final String eventId;
  final String eventTitle;
  final String eventDate;
  final String eventLocation;
  final String customerName;
  final String customerEmail;
  final int ticketCount;
  final int totalPrice;
  final DateTime bookedAt;
  final bool isCancelled;

  Booking({
    required this.id,
    required this.eventId,
    required this.eventTitle,
    required this.eventDate,
    required this.eventLocation,
    required this.customerName,
    required this.customerEmail,
    required this.ticketCount,
    required this.totalPrice,
    required this.bookedAt,
    this.isCancelled = false,
  });

  Map<String, dynamic> toJson() => {
    'id': id, 'eventId': eventId, 'eventTitle': eventTitle,
    'eventDate': eventDate, 'eventLocation': eventLocation,
    'customerName': customerName, 'customerEmail': customerEmail,
    'ticketCount': ticketCount, 'totalPrice': totalPrice,
    'bookedAt': bookedAt.toIso8601String(), 'isCancelled': isCancelled,
  };

  factory Booking.fromJson(Map<String, dynamic> json) => Booking(
    id: json['id'] as String,
    eventId: json['eventId'] as String,
    eventTitle: json['eventTitle'] as String,
    eventDate: json['eventDate'] as String,
    eventLocation: json['eventLocation'] as String,
    customerName: json['customerName'] as String,
    customerEmail: json['customerEmail'] as String,
    ticketCount: json['ticketCount'] as int,
    totalPrice: json['totalPrice'] as int,
    bookedAt: DateTime.parse(json['bookedAt'] as String),
    isCancelled: json['isCancelled'] as bool? ?? false,
  );

  Booking copyWith({bool? isCancelled}) => Booking(
    id: id, eventId: eventId, eventTitle: eventTitle, eventDate: eventDate,
    eventLocation: eventLocation, customerName: customerName,
    customerEmail: customerEmail, ticketCount: ticketCount,
    totalPrice: totalPrice, bookedAt: bookedAt,
    isCancelled: isCancelled ?? this.isCancelled,
  );
}
