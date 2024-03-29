import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

import '../manager/event_bloc.dart';

class MapScreen extends StatefulWidget {

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late CameraPosition initialCameraPosition;

  final Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = {};
  LocationData? currentLocation;

  @override
  void initState() {
    initialCameraPosition = const CameraPosition(
      target: LatLng(30.057204211139034, 31.330601125682183),
      zoom: 15,
    );
    getCurrentLocation();

    super.initState();
  }

  Future<void> getCurrentLocation() async {
    Location location = Location();

    try {
      currentLocation = await location.getLocation();
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
      setState(() {      });
    } catch (e) {
      print("Error getting location: $e");
    }
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
          // Add markers for each event location
          markers = state.events.map((event) {
            return Marker(
              markerId: MarkerId(event.id.toString()),
              position: LatLng(event.latitude, event.longitude),
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
              icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueBlue),
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
                  onMapCreated: (controller) {
                    _controller.complete(controller);
                  }));
        } else if (state is EventError) {
          return Center(child: Text(state.message));
        } else {
          return const Center(child: Text('Unknown state'));
        }
      },
    );
  }
}
