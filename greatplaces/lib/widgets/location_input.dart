import 'package:flutter/material.dart';
import 'package:greatplaces/helpers/maps_api.dart';
import 'package:greatplaces/screens/maps_screen.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationInput extends StatefulWidget {
  Function _selectPlace;

  LocationInput(this._selectPlace);
  @override
  _LocationInputState createState() => _LocationInputState();
}

class _LocationInputState extends State<LocationInput> {
  String _previewImageUrl;

  void _showPreview(double latitude, double longitude) {
    final previewUrl = MapsApi.generateLocationPreview(
        latitude: latitude, longitude: longitude);
    setState(() {
      _previewImageUrl = previewUrl;
    });
  }

  Future<void> _getCurrentUserLocation() async {
    try {
      final locationData = await Location().getLocation();
      _showPreview(locationData.latitude, locationData.longitude);
      widget._selectPlace(locationData.latitude, locationData.longitude);
    } catch (error) {
      return;
    }
  }

  Future<void> _selectOnMap() async {
    final LatLng selectedLocation =
        await Navigator.of(context).push(MaterialPageRoute(
            fullscreenDialog: true,
            builder: (ctx) => Maps(
                  isSelecting: true,
                )));
    if (selectedLocation == null) return null;
    _showPreview(selectedLocation.latitude, selectedLocation.longitude);
    widget._selectPlace(selectedLocation.latitude, selectedLocation.longitude);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Container(
          height: 170,
          width: double.infinity,
          alignment: Alignment.center,
          decoration:
              BoxDecoration(border: Border.all(width: 1, color: Colors.grey)),
          child: _previewImageUrl == null
              ? Text(
                  'No location chosen',
                  textAlign: TextAlign.center,
                )
              : Image.network(
                  _previewImageUrl,
                  fit: BoxFit.cover,
                  width: double.infinity,
                ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            FlatButton.icon(
              icon: Icon(Icons.location_on),
              textColor: Theme.of(context).primaryColor,
              onPressed: _getCurrentUserLocation,
              label: Text('Current Location'),
            ),
            FlatButton.icon(
              icon: Icon(Icons.map),
              textColor: Theme.of(context).primaryColor,
              onPressed: _selectOnMap,
              label: Text('Select On Map'),
            )
          ],
        )
      ],
    );
  }
}
