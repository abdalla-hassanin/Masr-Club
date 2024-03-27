class Event {
  final int id;
  final String name;
  final String category;
  final String location;
  final double latitude;
  final double longitude;
  final String description;
  final String date;
  final String time;

  Event({
    required this.id,
    required this.name,
    required this.category,
    required this.location,
    required this.latitude,
    required this.longitude,
    required this.description,
    required this.date,
    required this.time,
  });
}
