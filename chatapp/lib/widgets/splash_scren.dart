import 'package:flutter/material.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Center(
              child: CircularProgressIndicator(),
            ),
            Text('Loading...'),
          ],
        ),
      ),
    );
  }
}
