import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:masr_club/app/domain/entities/event.dart';

class EventMapScreen extends StatefulWidget {
  final Event event;

  const EventMapScreen({super.key, required this.event});

  @override
  State<EventMapScreen> createState() => _EventMapScreenState();
}

class _EventMapScreenState extends State<EventMapScreen> {
  final Completer<GoogleMapController> _controller = Completer();

  LocationData? currentLocation;
  List<LatLng> polylineCoordinates = [];

  @override
  void initState() {
    getCurrentLocation();
    super.initState();
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();

    try {
      currentLocation = await location.getLocation();
      getPolyPoints();
      GoogleMapController googleMapController = await _controller.future;

      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 13,
            target:
                LatLng(currentLocation!.latitude!, currentLocation!.longitude!),
          ),
        ),
      );
      setState(() {});
    } catch (e) {
      print("Error getting location: $e");
    }
  }

  Future<void> getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints();

    PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
      'AIzaSyATHyo6xXgRRggSUoayBnMhwpfuOKwXYNY',
      // Replace with your Google Maps API key
      PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      PointLatLng(widget.event.latitude, widget.event.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylineCoordinates.add(LatLng(point.latitude, point.longitude));
      });
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: currentLocation == null
          ? const Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: const CameraPosition(
                target: LatLng(0, 0),
                zoom: 13,
              ),
              polylines: {
                Polyline(
                  polylineId: const PolylineId('route'),
                  points: polylineCoordinates,
                  color: Colors.blue,
                  width: 6,
                ),
              },
              markers: {
                Marker(
                  markerId: const MarkerId('current_location'),
                  position: LatLng(
                    currentLocation!.latitude!,
                    currentLocation!.longitude!,
                  ),
                  infoWindow: const InfoWindow(
                    title: 'Current Location',
                  ),
                ),
                Marker(
                  markerId: const MarkerId('event_location'),
                  position:
                      LatLng(widget.event.latitude, widget.event.longitude),
                  infoWindow: InfoWindow(
                    title: widget.event.name,
                    snippet: widget.event.location,
                  ),
                ),
              },
              onMapCreated: (GoogleMapController controller) {
                _controller.complete(controller);
              },
            ),
    );
  }
}
