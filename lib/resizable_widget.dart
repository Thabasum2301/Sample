import 'package:flutter/material.dart';

import 'manipulating_ball.dart';

class ResizableWidget extends StatefulWidget {
  ResizableWidget({required this.child, required this.tableWidgetKey});

  final Widget child;
  final GlobalKey<State<StatefulWidget>> tableWidgetKey;

  @override
  _ResizableWidgetState createState() => _ResizableWidgetState();
}

const ballDiameter = 15.0;

class _ResizableWidgetState extends State<ResizableWidget> {
  double height = 100;
  double width = 100;

  double top = 0;
  double left = 0;

  double _angle = 0.0;
  double _oldAngle = 0.0;
  double _angleDelta = 0.0;

  void onDrag(double dx, double dy) {
    var newHeight = height + dy;
    var newWidth = width + dx;

    setState(() {
      height = newHeight > 0 ? newHeight : 0;
      width = newWidth > 0 ? newWidth : 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    final RenderBox? box = widget.tableWidgetKey.currentContext?.findRenderObject() as RenderBox?;
    top = box?.localToGlobal(Offset.zero).dx ?? top;
    left = box?.localToGlobal(Offset.zero).dy ?? left;

    return Stack(
      children: <Widget>[
        Positioned(
            top: top,
            left: left,
            child: Transform.rotate(
              angle: _angle,
              child: Container(
                  height: height,
                  width: width,
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.blue, width: 2)),
                  child: widget.child),
            )),
        // top left
        Positioned(
          top: top - ballDiameter / 2,
          left: left - ballDiameter + 20 / 2,
          child: ManipulatingBall(
            ballDiameter: ballDiameter,
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;
              var newHeight = height - 2 * mid;
              var newWidth = width - 2 * mid;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top + mid;
                left = left + mid;
              });
            },
          ),
        ),
        // top middle
        Positioned(
          top: top - ballDiameter  / 2 - 46,
          left: left + width / 2 - ballDiameter + 10 / 2,
          child: Column(
            children: [
              Container(
                width: 16,
                height: 16,
                decoration: BoxDecoration(
                  border:Border.all(color: Colors.blue),
                ),
                child: LayoutBuilder(
                  builder: (context, constraints) {
                    Offset centerOfGestureDetector =
                    Offset(constraints.maxWidth / 2, 130);
                    return GestureDetector(
                      behavior: HitTestBehavior.translucent,
                      onPanStart: (details) {
                        final touchPositionFromCenter =
                            details.localPosition -
                                centerOfGestureDetector;
                        _angleDelta = _oldAngle -
                            touchPositionFromCenter.direction;
                      },
                      onPanEnd: (details) {
                        setState(
                              () {
                            _oldAngle = _angle;
                          },
                        );
                      },
                      onPanUpdate: (details) {
                        final touchPositionFromCenter =
                            details.localPosition -
                                centerOfGestureDetector;

                        setState(
                              () {
                            _angle = touchPositionFromCenter.direction +
                                _angleDelta;
                          },
                        );
                      },
                    );
                  },
                ),
              ),
              Container(
                height: 30,
                width: 5,
                decoration: BoxDecoration(border: Border.all(color: Colors.blue)),
              ),
              ManipulatingBall(
                ballDiameter: ballDiameter,
                onDrag: (dx, dy) {
                  var newHeight = height - dy;
                  setState(() {
                    height = newHeight > 0 ? newHeight : 0;
                    top = top + dy;
                  });
                },
              ),
            ],
          ),
        ),
        // top right
        Positioned(
          top: top - ballDiameter / 2,
          left: left + width - ballDiameter + 10 / 2,
          child: ManipulatingBall(
            ballDiameter: ballDiameter,
            onDrag: (dx, dy) {
              var mid = (dx + (dy * -1)) / 2;

              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
          ),
        ),
        // center right
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left + width - ballDiameter + 14 / 2,
          child: ManipulatingBall(
            ballDiameter: ballDiameter,
            onDrag: (dx, dy) {
              var newWidth = width + dx;
              setState(() {
                width = newWidth > 0 ? newWidth : 0;
              });
            },
          ),
        ),
        // bottom right
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left + width - ballDiameter + 10 / 2,
          child: ManipulatingBall(
            ballDiameter: ballDiameter,
            onDrag: (dx, dy) {
              var mid = (dx + dy) / 2;

              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
          ),
        ),
        // bottom center
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left + width / 2 - ballDiameter + 10 / 2,
          child: ManipulatingBall(
            ballDiameter: ballDiameter,
            onDrag: (dx, dy) {
              var newHeight = height + dy;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
              });
            },
          ),
        ),
        // bottom left
        Positioned(
          top: top + height - ballDiameter / 2,
          left: left - ballDiameter + 20 / 2,
          child: ManipulatingBall(
            ballDiameter: ballDiameter,
            onDrag: (dx, dy) {
              var mid = ((dx * -1) + dy) / 2;

              var newHeight = height + 2 * mid;
              var newWidth = width + 2 * mid;

              setState(() {
                height = newHeight > 0 ? newHeight : 0;
                width = newWidth > 0 ? newWidth : 0;
                top = top - mid;
                left = left - mid;
              });
            },
          ),
        ),
        //left center
        Positioned(
          top: top + height / 2 - ballDiameter / 2,
          left: left - ballDiameter + 10 / 2,
          child: ManipulatingBall(
            ballDiameter: ballDiameter,
            onDrag: (dx, dy) {
              var newWidth = width - dx;

              setState(() {
                width = newWidth > 0 ? newWidth : 0;
                left = left + dx;
              });
            },
          ),
        ),
        Positioned(
            top: top + height / 2 - ballDiameter / 2,
            left: left + width / 2 - ballDiameter / 2,
            child: ManipulatingBall(
              ballDiameter: ballDiameter,
              onDrag: (dx, dy) {
                setState(() {
                  top = top + dy;
                  left = left + dx;
                });
              },
            )),
      ],
    );
  }
}
