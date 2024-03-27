import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:masr_club/app/domain/entities/event.dart';

class EventMapScreen extends StatelessWidget {
  final Event event;

  const EventMapScreen({super.key, required this.event});

  @override
  Widget build(BuildContext context) {
    Set<Marker> markers = {};

    CameraPosition initialCameraPosition = CameraPosition(
      target: LatLng(event.latitude, event.longitude),
      zoom: 15,
    );

    markers.add(Marker(
      markerId: const MarkerId('event_location'),
      position: LatLng(event.latitude, event.longitude),
      infoWindow: InfoWindow(
        title: event.name,
        snippet: event.location,
      ),
    ));
    return Scaffold(
      body: GoogleMap(
        initialCameraPosition: initialCameraPosition,
        markers: markers,
      ),
    );
  }
}
