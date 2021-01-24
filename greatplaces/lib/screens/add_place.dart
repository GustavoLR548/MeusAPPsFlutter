import 'dart:io';
import 'package:flutter/material.dart';
import 'package:greatplaces/models/place.dart';
import 'package:greatplaces/widgets/image_input.dart';
import 'package:greatplaces/widgets/location_input.dart';
import 'package:provider/provider.dart';
import '../providers/places_provider.dart';

class AddPlace extends StatefulWidget {
  static const routeName = '/add-place';
  @override
  _AddPlaceState createState() => _AddPlaceState();
}

class _AddPlaceState extends State<AddPlace> {
  final _textController = TextEditingController();
  File _pickedImage;
  PlaceLocation _pickedLocation;

  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  void _selectImage(File pickedImage) {
    _pickedImage = pickedImage;
  }

  void _selectPlace(double latitude, double longitude) {
    _pickedLocation = PlaceLocation(latitude: latitude, longitude: longitude);
  }

  void _savePlace() {
    if (_textController.text.isEmpty ||
        _pickedImage == null ||
        _pickedLocation == null) return;
    Provider.of<PlacesProvider>(context, listen: false)
        .addPlace(_textController.text, _pickedImage, _pickedLocation);
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a New Place'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(10),
                child: Column(
                  children: <Widget>[
                    TextField(
                      decoration: InputDecoration(
                        labelText: 'Title',
                      ),
                      controller: _textController,
                    ),
                    SizedBox(
                      height: 15,
                    ),
                    ImageInput(_selectImage),
                    SizedBox(
                      height: 10,
                    ),
                    LocationInput(_selectPlace),
                  ],
                ),
              ),
            ),
          ),
          RaisedButton.icon(
            icon: Icon(Icons.add),
            label: Text('Add Place'),
            elevation: 0,
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            color: Theme.of(context).accentColor,
            onPressed: _savePlace,
          )
        ],
      ),
    );
  }
}
