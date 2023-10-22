import 'package:flutter/material.dart';

// void main() {
//   runApp(MyApp());
// }

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: Text('Nested Oval Containers'),
        ),
        body: Center(
          child: Container(
            width: 200,
            height: 300,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(
                  150), // Half of the width for a perfect circle
              color: Colors.blue,
            ),
            child: Container(
              margin: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                    100), // Half of the width for a perfect circle
                color: Colors.white,
              ),
              child: Center(
                child: Text(
                  'Inner Container',
                  style: TextStyle(fontSize: 20),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
