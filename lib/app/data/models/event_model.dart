import '../../domain/entities/event.dart';

class EventModel extends Event {
  EventModel({
    required super.id,
    required super.name,
    required super.category,
    required super.location,
    required super.latitude,
    required super.longitude,
    required super.description,
    required super.date,
    required super.time,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    return EventModel(
      id: json['id'],
      name: json['name'],
      category: json['category'],
      location: json['location'],
      latitude: json['latitude'],
      longitude: json['longitude'],
      description: json['description'],
      date: json['date'],
      time: json['time'],
    );
  }
}