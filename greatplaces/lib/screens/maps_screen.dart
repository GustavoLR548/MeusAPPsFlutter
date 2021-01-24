import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:greatplaces/models/place.dart';

class Maps extends StatefulWidget {
  final PlaceLocation initialLocation;
  final bool isSelecting;

  Maps(
      {this.initialLocation =
          const PlaceLocation(latitude: 37.422, longitude: -122.084),
      this.isSelecting = false});
  @override
  _MapsState createState() => _MapsState();
}

class _MapsState extends State<Maps> {
  LatLng _pickedLocation;

  void _selectedLocation(LatLng position) {
    setState(() {
      _pickedLocation = position;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Map'),
          actions: <Widget>[
            if (widget.isSelecting)
              IconButton(
                  icon: Icon(Icons.check),
                  onPressed: _pickedLocation == null
                      ? null
                      : () {
                          Navigator.of(context).pop(_pickedLocation);
                        })
          ],
        ),
        body: GoogleMap(
          initialCameraPosition: CameraPosition(
              zoom: 16,
              target: LatLng(widget.initialLocation.latitude,
                  widget.initialLocation.longitude)),
          onTap: widget.isSelecting ? _selectedLocation : null,
          markers: (_pickedLocation == null && widget.isSelecting)
              ? null
              : {
                  Marker(
                      markerId: MarkerId(''),
                      position: _pickedLocation ??
                          LatLng(widget.initialLocation.latitude,
                              widget.initialLocation.longitude))
                },
        ));
  }
}
