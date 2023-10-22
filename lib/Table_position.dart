import 'package:flutter/material.dart';

// void main() => runApp( XYTableFloor());

class XYTableFloor extends StatelessWidget {
   XYTableFloor({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.grey,
        body: _diamondTable(context),
        appBar: AppBar(
          title: const Text('Table XY Floor'),
        ),
      ),
    );
  }

  Widget _diamondTable(BuildContext context) {
    var borderRadius = BorderRadius.all(Radius.elliptical(100, 50));

    return Center(
      child: Column(
        children: [
          const SizedBox(height: 30),
          Stack(
            children: [
              Transform.rotate(
                angle: 90,
                child: Container(
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey.shade50),
                    borderRadius: borderRadius,
                  ),
                  padding: const EdgeInsets.all(2),
                  child: Container(
                    height: 67,
                    width: 218,
                    decoration: BoxDecoration(
                      borderRadius: borderRadius,
                      color: Colors.grey.shade50,
                    ),
                  ),
                ),
              ),
              Positioned.fill(child:Align( alignment: Alignment.center, child: Text('T001', style: TextStyle(color: Colors.grey))),
              )
            ],
          ),
        ],
      ),
    );
  }

}
