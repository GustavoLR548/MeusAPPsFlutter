import 'package:flutter/material.dart';
import 'package:greatplaces/screens/add_place.dart';
import 'package:greatplaces/screens/place_detail_screen.dart';
import 'package:provider/provider.dart';
import '../providers/places_provider.dart';

class PlacesList extends StatelessWidget {
  static const routeName = '/places-list';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Places'),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.add),
              onPressed: () {
                Navigator.of(context).pushNamed(AddPlace.routeName);
              },
            )
          ],
        ),
        body: FutureBuilder(
          future:
              Provider.of<PlacesProvider>(context, listen: false).fetchPlaces(),
          builder: (ctx, snapshot) => snapshot.connectionState ==
                  ConnectionState.waiting
              ? Center(
                  child: CircularProgressIndicator(),
                )
              : Consumer<PlacesProvider>(
                  child: Center(child: Text('Got no places yet')),
                  builder: (ctx, greatPlaces, ch) =>
                      greatPlaces.items.length <= 0
                          ? ch
                          : ListView.builder(
                              itemCount: greatPlaces.items.length,
                              itemBuilder: (ctx, i) => ListTile(
                                leading: CircleAvatar(
                                  backgroundImage:
                                      FileImage(greatPlaces.items[i].image),
                                ),
                                title: Text(greatPlaces.items[i].title),
                                subtitle:
                                    Text(greatPlaces.items[i].location.address),
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      PlaceDetailScreen.routeName,
                                      arguments: greatPlaces.items[i].id);
                                },
                              ),
                            )),
        ));
  }
}
