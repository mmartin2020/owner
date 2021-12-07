import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:owner/Helper/CommonWidgets.dart';
import 'package:owner/Helper/SharedManaged.dart';

class GoogleMapScreen extends StatefulWidget {
  final String resName;
  final double latitude;
  final double longitude;

  GoogleMapScreen({this.resName, this.latitude, this.longitude});
  @override
  _GoogleMapScreenState createState() => _GoogleMapScreenState();
}

class _GoogleMapScreenState extends State<GoogleMapScreen> {
  Completer<GoogleMapController> _controller = Completer();
  Set<Marker> markers = Set();

  CameraPosition _kGooglePlex = CameraPosition(
    target:
        LatLng(SharedManager.shared.latitude, SharedManager.shared.longitude),
    zoom: 14.4746,
  );

  @override
  void initState() {
    markers.addAll([
      Marker(
        markerId: MarkerId('value'),
        position: LatLng(this.widget.latitude, this.widget.longitude),
      ),
    ]);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: commonAppbar(this.widget.resName, []),
      body: Container(
        child: GoogleMap(
          mapType: MapType.normal,
          initialCameraPosition: _kGooglePlex,
          onMapCreated: (GoogleMapController controller) {
            _controller.complete(controller);
          },
          markers: markers,
        ),
      ),
    );
  }
}
