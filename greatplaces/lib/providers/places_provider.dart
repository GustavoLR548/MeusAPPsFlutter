import 'dart:io';

import 'package:flutter/foundation.dart';
import '../models/place.dart';
import '../helpers/sql_database.dart';
import '../helpers/maps_api.dart';

class PlacesProvider with ChangeNotifier {
  List<Place> _items = [];

  List<Place> get items {
    return [..._items];
  }

  Future<void> addPlace(
      String title, File image, PlaceLocation location) async {
    final address =
        await MapsApi.getPlaceAdress(location.latitude, location.longitude);
    final updatedLocation = PlaceLocation(
        latitude: location.latitude,
        longitude: location.longitude,
        address: address);
    final newPlace = Place(
        id: DateTime.now().toString(),
        image: image,
        title: title,
        location: updatedLocation);
    _items.add(newPlace);
    notifyListeners();
    SQLDatabase.insert('user_places', {
      'id': newPlace.id,
      'title': newPlace.title,
      'image': newPlace.image,
      'loc_lat': newPlace.location.latitude,
      'loc_lng': newPlace.location.longitude,
      'address': newPlace.location.address,
    });
  }

  Place findById(String id) {
    return _items.firstWhere((place) => place.id == id);
  }

  Future<void> fetchPlaces() async {
    final dataList = await SQLDatabase.read('user_places');
    _items = dataList
        .map((item) => Place(
            id: item['id'],
            title: item['title'],
            image: File(item['image']),
            location: PlaceLocation(
                latitude: item['loc_lat'],
                longitude: item['loc_lng'],
                address: item['address'])))
        .toList();
    notifyListeners();
  }
}
