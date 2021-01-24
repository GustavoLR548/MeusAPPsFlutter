import 'package:flutter/material.dart';
import 'package:greatplaces/providers/places_provider.dart';
import 'package:greatplaces/screens/add_place.dart';
import 'package:greatplaces/screens/place_detail_screen.dart';
import 'package:greatplaces/screens/places_list.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => PlacesProvider(),
        )
      ],
      child: MaterialApp(
        title: 'Great Places',
        theme: ThemeData(
          primarySwatch: Colors.indigo,
          accentColor: Colors.amber,
        ),
        home: PlacesList(),
        routes: {
          AddPlace.routeName: (ctx) => AddPlace(),
          PlaceDetailScreen.routeName: (ctx) => PlaceDetailScreen(),
        },
      ),
    );
  }
}
