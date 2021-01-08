import 'package:flutter/material.dart';
import 'package:mealsapp/models/meal.dart';
import 'package:mealsapp/screens/meal_details_screen.dart';
import 'package:mealsapp/widgets/information_box.dart';

class MealItem extends StatelessWidget {
  final String id;
  final String title;
  final String imageUrl;
  final int duration;
  final Complexity complexity;
  final Affordability affordability;

  //final Function removeItem;

  MealItem({
    //this.removeItem,
    @required this.id,
    @required this.title,
    @required this.imageUrl,
    @required this.duration,
    @required this.complexity,
    @required this.affordability,
  });

  void _selectMeal(BuildContext ctx) {
    Navigator.of(ctx)
        .pushNamed(MealDetails.routeName, arguments: this.id)
        .then((result) => {
              if (result != null) {/*removeItem(result)*/}
            });
  }

  String get _complexityText {
    String resp = 'Unknown';
    if (complexity == Complexity.Simple)
      resp = 'Simple';
    else if (complexity == Complexity.Challenging)
      resp = 'Challenging';
    else if (complexity == Complexity.Hard) resp == 'Hard';

    return resp;
  }

  @override
  Widget build(BuildContext context) {
    print(this.affordability);
    final foodImage = Image.network(
      imageUrl,
      height: 250,
      width: double.infinity,
      fit: BoxFit.cover,
    );

    return InkWell(
        onTap: () => _selectMeal(context),
        child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
            elevation: 4,
            margin: EdgeInsets.all(10),
            child: Column(
              children: <Widget>[
                Stack(children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(15),
                        topRight: Radius.circular(15)),
                    child: foodImage,
                  ),
                  Positioned(
                    bottom: 10,
                    left: 50,
                    child: Container(
                        width: 300,
                        child: Text(
                          this.title,
                          style: TextStyle(
                            fontSize: 26,
                            backgroundColor: Colors.black54,
                            color: Colors.white,
                          ),
                          softWrap: true,
                          overflow: TextOverflow.fade,
                        )),
                  )
                ]),
                Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: <Widget>[
                          InformationBox(
                              information: '${this.duration} min',
                              icon: Icons.schedule,
                              width: 6),
                          InformationBox(
                              information: _complexityText,
                              icon: Icons.work,
                              width: 6),
                          InformationBox(
                              information:
                                  this.affordability.toString().split('.')[1],
                              icon: Icons.attach_money,
                              width: 6)
                        ]))
              ],
            )));
  }
}
