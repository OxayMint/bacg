import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapView extends StatefulWidget {
  @override
  _MapViewState createState() => _MapViewState();
}

class _MapViewState extends State<MapView> {
  // Completer<GoogleMapController> _controller = Completer();
  BitmapDescriptor _markerIcon;
  GoogleMapController controller;

  final LatLng position = LatLng(40.38204, 49.841315);
  // final CameraPosition address =
  @override
  Widget build(BuildContext context) {
    _createMarkerImageFromAsset(context);
    return Container(
      height: 250,
      child: GoogleMap(
        initialCameraPosition: CameraPosition(
          target: position,
          zoom: 17,
        ),
        mapType: MapType.normal,
        onMapCreated: _onMapCreated,
        myLocationButtonEnabled: false,
        myLocationEnabled: false,
        markers: _createMarker(),
      ),
    );
  }

  Set<Marker> _createMarker() {
    return <Marker>[
      Marker(
        markerId: MarkerId("BACG"),
        position: position,
        icon: _markerIcon,
      ),
    ].toSet();
  }

  Future<void> _createMarkerImageFromAsset(BuildContext context) async {
    if (_markerIcon == null) {
      final ImageConfiguration imageConfiguration =
          createLocalImageConfiguration(context, size: Size.square(12));
      Uint8List markerIcon = await getBytesFromAsset('assets/marker.png', 78);

      _updateBitmap(BitmapDescriptor.fromBytes(markerIcon));
    }
  }

  void _updateBitmap(BitmapDescriptor bitmap) {
    setState(() {
      _markerIcon = bitmap;
      print("imge lodaded");
    });
  }

  void _onMapCreated(GoogleMapController controllerParam) {
    setState(() {
      controller = controllerParam;
    });
  }

  Future<Uint8List> getBytesFromAsset(String path, int width) async {
    ByteData data = await rootBundle.load(path);
    ui.Codec codec = await ui.instantiateImageCodec(data.buffer.asUint8List(),
        targetWidth: width);
    ui.FrameInfo fi = await codec.getNextFrame();
    return (await fi.image.toByteData(format: ui.ImageByteFormat.png))
        .buffer
        .asUint8List();
  }
}
