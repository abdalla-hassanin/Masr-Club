import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:masr_club/core/constants.dart';

import '../manager/event_bloc.dart';

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition initialCameraPosition;
  late Completer<GoogleMapController> _controller;
  Set<Marker> markers = {};
  LocationData? currentLocation;
  Set<Polyline> polylines = {};

  @override
  void initState() {
    super.initState();
    initialCameraPosition = const CameraPosition(
      target: LatLng(30.057204211139034, 31.330601125682183),
      zoom: 15,
    );
    _controller = Completer();
    getCurrentLocation();
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();

    try {
      currentLocation = await location.getLocation();
      GoogleMapController googleMapController = await _controller.future;

      googleMapController.animateCamera(
        CameraUpdate.newCameraPosition(
          CameraPosition(
            zoom: 15,
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

  void _onMarkerTapped(MarkerId markerId) async {
    // Get the selected marker's position
    final selectedMarker =
        markers.firstWhere((marker) => marker.markerId == markerId);
    final LatLng selectedPosition = selectedMarker.position;

    // Create a route between current location and selected marker
    final List<LatLng> polylinePoints =
        await _createPolylines(selectedPosition);

    setState(() {
      polylines.add(Polyline(
        polylineId: const PolylineId('route'),
        points: polylinePoints,
        color: Colors.blue,
        width: 6,
      ));
    });
  }

  Future<List<LatLng>> _createPolylines(LatLng destination) async {
    List<LatLng> polylinePoints = [];

    PolylinePoints polylinePointsProvider = PolylinePoints();
    PolylineResult result =
        await polylinePointsProvider.getRouteBetweenCoordinates(
          googleMapsAPIkey,
      // Replace with your Google Maps API key
      PointLatLng(currentLocation!.latitude!, currentLocation!.longitude!),
      PointLatLng(destination.latitude, destination.longitude),
    );

    if (result.points.isNotEmpty) {
      result.points.forEach((PointLatLng point) {
        polylinePoints.add(LatLng(point.latitude, point.longitude));
      });
    }

    return polylinePoints;
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventBloc, EventState>(
      builder: (context, state) {
        if (state is EventInitial) {
          return const Center(child: Text('No events yet.'));
        } else if (state is EventLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is EventLoaded) {
          markers = state.events.map((event) {
            return Marker(
              markerId: MarkerId(event.id.toString()),
              position: LatLng(event.latitude, event.longitude),
              onTap: () => _onMarkerTapped(MarkerId(event.id.toString())),
              infoWindow: InfoWindow(
                title: event.name,
                snippet: event.location,
              ),
            );
          }).toSet();
          markers.add(
            Marker(
              markerId: const MarkerId('current_location'),
              position: LatLng(
                currentLocation!.latitude!,
                currentLocation!.longitude!,
              ),
              icon: BitmapDescriptor.defaultMarkerWithHue(
                  BitmapDescriptor.hueBlue),
              infoWindow: const InfoWindow(
                title: 'Current Location',
              ),
            ),
          );
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: GoogleMap(
              initialCameraPosition: initialCameraPosition,
              markers: markers,
              polylines: polylines,
              onMapCreated: (controller) {
                _controller.complete(controller);
              },
            ),
          );
        } else if (state is EventError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}
