
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class CommunityMapScreen extends StatefulWidget {
  const CommunityMapScreen({super.key});

  @override
  State<CommunityMapScreen> createState() => _CommunityMapScreenState();
}

class _CommunityMapScreenState extends State<CommunityMapScreen> {
  GoogleMapController? _mapController;

  static const LatLng _initialPosition = LatLng(30.0444, 31.2357);

  final Set<Marker> _markers = {
    const Marker(
      markerId: MarkerId('member_cairo'),
      position: LatLng(30.0444, 31.2357),
      infoWindow: InfoWindow(
        title: 'Ahmed Mohamed',
        snippet: 'Cairo',
      ),
    ),
    const Marker(
      markerId: MarkerId('member_alexandria'),
      position: LatLng(31.2001, 29.9187),
      infoWindow: InfoWindow(
        title: 'Mariam Ali',
        snippet: 'Alexandria',
      ),
    ),
    const Marker(
      markerId: MarkerId('member_luxor'),
      position: LatLng(25.6872, 32.6396),
      infoWindow: InfoWindow(
        title: 'Omar Hassan',
        snippet: 'Luxor',
      ),
    ),
  };

  @override
  void dispose() {
    _mapController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Community Map'),
        centerTitle: true,
      ),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _initialPosition,
          zoom: 5.5,
        ),
        markers: _markers,
        mapType: MapType.normal,
        onMapCreated: (controller) {
          _mapController = controller;
        },
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
      ),
    );
  }
}