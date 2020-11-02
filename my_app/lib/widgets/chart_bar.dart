import 'package:flutter/material.dart';

class ChartBar extends StatelessWidget {
  final String label;
  final double totalSpending;
  final double spendingPctOfTotal;

  ChartBar(this.label, this.totalSpending, this.spendingPctOfTotal);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (ctx, constrains) {
        return Column(
          children: <Widget>[
            Container(
                height: constrains.maxHeight * 0.15,
                child: FittedBox(
                  child: Text('R\$${totalSpending.toStringAsFixed(0)}'),
                )),
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),
            Container(
              height: constrains.maxHeight * 0.60,
              width: 10,
              child: Stack(
                children: <Widget>[
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.0),
                      color: Color.fromRGBO(220, 220, 220, 1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  FractionallySizedBox(
                    heightFactor: spendingPctOfTotal,
                    child: Container(
                      decoration: BoxDecoration(
                        color: Theme.of(context).primaryColor,
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  )
                ],
              ),
            ),
            SizedBox(
              height: constrains.maxHeight * 0.05,
            ),
            Container(
                height: constrains.maxHeight * 0.15,
                child: FittedBox(child: Text(label))),
          ],
        );
      },
    );
  }
}
