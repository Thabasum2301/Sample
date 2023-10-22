import 'package:flutter/material.dart';
import 'package:sample_showtimepicker/resizable_widget.dart';

void main() => runApp(ResizeWidget());

class ResizeWidget extends StatefulWidget {
  @override
  _ResizeWidgetState createState() => _ResizeWidgetState();
}

class _ResizeWidgetState extends State<ResizeWidget> {
  @override
  Widget build(BuildContext context) {
    var tableWidgetKey = GlobalKey();
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: Container(
          // padding: EdgeInsets.only(top: 50),
          child: ResizableWidget(
            tableWidgetKey: tableWidgetKey,
            child: Container(
              height: 100,
              width: 100,
              child: Center(child: Text('Resize')),
              color: Colors.red,
            ),

          ),
        ),
      ),
    );
  }
}

class _CirclePainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = size.width / 2;
    final paint = Paint()
      ..color = Colors.blue;

    canvas.drawCircle(center, radius, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}

