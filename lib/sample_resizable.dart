import 'package:flutter/material.dart';

void main() => runApp(HomePage());

const double dragWidgetSize = 30;

class HomePage extends StatelessWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('First Example'),
          centerTitle: true,
        ),
        body: LayoutBuilder(
          builder: (context, constraint) {
            double areaHeight = constraint.maxHeight * 0.8;
            double areaWidth = constraint.maxWidth * 0.8;

            return Container(
              width: constraint.maxWidth,
              height: constraint.maxHeight,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    Colors.lightBlue.shade200,
                    Colors.blue.shade700,
                  ],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 10),
                  const Text(
                    'Widget Area',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    height: constraint.maxHeight * 0.8,
                    width: constraint.maxWidth * 0.8,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: Colors.white,
                        width: 2,
                      ),
                    ),
                    child: ResizableWidget(
                      areaHeight: areaHeight,
                      areaWidth: areaWidth,
                      height: 250,
                      width: 250,
                      minHeight: 100,
                      minWidth: 100,
                      dragWidgetsArea: const Size.square(30 / 2),
                      triggersList: DragTriggersEnum.values
                          .map(
                            (e) => Trigger(
                              dragTriggerType: e,
                              child: Container(
                                height: 30,
                                width: 30,
                                decoration: const BoxDecoration(
                                  color: Colors.white38,
                                  shape: BoxShape.circle,
                                ),
                              ),
                            ),
                          )
                          .toList(),
                      child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(
                            color: Colors.white,
                            width: 2,
                          ),
                          shape: BoxShape.circle
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

typedef DragDetailsCallback = void Function(double dx, double dy);

enum DragTriggersEnum {
  topLeft(Alignment.topLeft),
  topCenter(Alignment.topCenter),
  topRight(Alignment.topRight),
  centerLeft(Alignment.centerLeft),
  center(Alignment.center),
  centerRight(Alignment.centerRight),
  bottomLeft(Alignment.bottomLeft),
  bottomCenter(Alignment.bottomCenter),
  bottomRight(Alignment.bottomRight);

  const DragTriggersEnum(this.alignment);
  final Alignment alignment;

  DragDetailsCallback getOnDragFunction(ResizableWidgetController controller) {
    switch (this) {
      case topLeft:
        return controller.onTopLeftDrag;
      case topCenter:
        return controller.onTopCenterDrag;
      case topRight:
        return controller.onTopRightDrag;
      case centerLeft:
        return controller.onCenterLeftDrag;
      case center:
        return controller.onCenterDrag;
      case centerRight:
        return controller.onCenterRightDrag;
      case bottomLeft:
        return controller.onBottomLeftDrag;
      case bottomCenter:
        return controller.onBottomCenterDrag;
      case bottomRight:
        return controller.onBottomRightDrag;
      default:
        return controller.onCenterDrag;
    }
  }
}

class ResizableWidget extends StatefulWidget {
  ResizableWidget({
    super.key,
    double? height,
    double? width,
    Offset? initialPosition,
    double minWidth = 0.0,
    double minHeight = 0.0,
    this.showDragWidgets,
    required double areaHeight,
    required double areaWidth,
    required this.child,
    required this.dragWidgetsArea,
    required this.triggersList,
  }) {
    height ??= areaHeight;
    width ??= areaWidth;
    initialPosition ??= Offset(areaWidth / 2, areaHeight / 2);
    size = CommonSizes(
      areaHeight: areaHeight,
      areaWidth: areaWidth,
      height: height,
      width: width,
      minHeight: minHeight,
      minWidth: minWidth,
      initialPosition: initialPosition,
    );
  }

  late final CommonSizes size;
  final bool? showDragWidgets;
  final Widget child;
  final Size dragWidgetsArea;
  final List<Trigger> triggersList;

  @override
  State<ResizableWidget> createState() => _ResizableWidgetState();
}

class _ResizableWidgetState extends State<ResizableWidget> {
  late final ResizableWidgetController controller;

  @override
  void initState() {
    controller = ResizableWidgetController();
    controller.init(
        finalSize: widget.size, showDragWidgets: widget.showDragWidgets);
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: controller,
      child: Stack(
        children: widget.triggersList.map((trigger) {
          return TriggerWidget(
            onDrag: trigger.dragTriggerType.getOnDragFunction(controller),
            trigger: trigger,
          );
        }).toList(),
      ),
      builder: (_, triggersStack) {
        return Stack(
          children: <Widget>[
            Positioned(
              top: controller.top,
              left: controller.left,
              bottom: controller.bottom,
              right: controller.right,
              child: widget.child,
            ),
            Positioned(
              top: controller.top - widget.dragWidgetsArea.height,
              left: controller.left - widget.dragWidgetsArea.width,
              bottom: controller.bottom - widget.dragWidgetsArea.height,
              right: controller.right - widget.dragWidgetsArea.width,
              child: Visibility(
                visible: controller.showDragWidgets,
                child: triggersStack!,
              ),
            ),
          ],
        );
      },
    );
  }
}

class ResizableWidgetController extends SizeCalculator with ChangeNotifier {
  late bool _showDragWidgets;
  bool get showDragWidgets => _showDragWidgets;

  void init({required CommonSizes finalSize, bool? showDragWidgets}) {
    super.initFields(finalSize);
    _showDragWidgets = showDragWidgets ?? true;
  }

  @override
  void setSize(
      {double? newTop, double? newLeft, double? newRight, double? newBottom}) {
    super.setSize(
        newBottom: newBottom,
        newTop: newTop,
        newLeft: newLeft,
        newRight: newRight);
    notifyListeners();
  }

  void toggleShowDragWidgets() {
    _showDragWidgets = !_showDragWidgets;
    notifyListeners();
  }

  void onTopLeftDrag(double dx, double dy) {
    double mid = (dx + dy) / 2;
    setSize(
      newTop: top + mid,
      newLeft: left + mid,
    );
  }

  void onTopCenterDrag(double dx, double dy) {
    setSize(newTop: top + dy);
  }

  void onTopRightDrag(double dx, double dy) {
    double mid = (dx + (dy * -1)) / 2;
    setSize(
      newTop: top - mid,
      newRight: right - mid,
    );
  }

  void onCenterLeftDrag(double dx, double dy) {
    setSize(newLeft: left + dx);
  }

  void onCenterDrag(double dx, double dy) {
    setSize(
      newTop: top + dy,
      newLeft: left + dx,
      newBottom: bottom - dy,
      newRight: right - dx,
    );
  }

  void onCenterRightDrag(double dx, double dy) {
    setSize(newRight: right - dx);
  }

  void onBottomLeftDrag(double dx, double dy) {
    double mid = ((dx * -1) + dy) / 2;
    setSize(newBottom: bottom - mid, newLeft: left - mid);
    notifyListeners();
  }

  void onBottomCenterDrag(double dx, double dy) {
    setSize(newBottom: bottom - dy);
  }

  void onBottomRightDrag(double dx, double dy) {
    double mid = (dx + dy) / 2;

    setSize(
      newRight: right - mid,
      newBottom: bottom - mid,
    );
  }
}

class SizeCalculator {
  late final CommonSizes _size;

  late double height;
  late double width;
  late double top;
  late double left;
  late double bottom;
  late double right;

  /// Initializes the fields
  /// It should called just once in widget lifecycle before [ResizableWidgetController] used
  void initFields(CommonSizes finalSize) {
    _size = finalSize;
    height = _size.height;
    width = _size.width;
    double newTop = _size.initialPosition.dy - height / 2;
    double newBottom = _size.areaHeight - height - newTop;
    double newLeft = _size.initialPosition.dx - (width / 2);
    double newRight = (_size.areaWidth - width) - newLeft;

    // init top & bottom
    if (newTop < 0) {
      bottom = newBottom + newTop;
    } else if (newBottom < 0) {
      top = newTop + newBottom;
    } else {
      bottom = newBottom;
      top = newTop;
    }
    // init left & right
    if (newLeft < 0) {
      right = newRight + newLeft;
    } else if (newRight < 0) {
      left = newLeft + newRight;
    } else {
      right = newRight;
      left = newLeft;
    }
  }

  /// Get new sizes and Calculate widget size
  /// If new sizes are safe then it will quantifies new sizes
  /// Else new sizes ignoring
  /// It called whenever user dragging
  void setSize({
    double? newTop,
    double? newLeft,
    double? newRight,
    double? newBottom,
  }) {
    newTop = newTop ?? top;
    newLeft = newLeft ?? left;
    newRight = newRight ?? right;
    newBottom = newBottom ?? bottom;
    calculateWidgetSize(
        top: newTop, left: newLeft, bottom: newBottom, right: newRight);
    if (checkTopBotMaxSize(newTop, newBottom)) {
      top = newTop;
      bottom = newBottom;
    }
    if (checkLeftRightMaxSize(newLeft, newRight)) {
      left = newLeft;
      right = newRight;
    }
    calculateWidgetSize(bottom: bottom, left: left, right: right, top: top);
  }

  /// Return True if [newTop] and [newBottom] are bigger than zero or equal it
  /// and the [height] bigger than [minHeight] or equal it
  bool checkTopBotMaxSize(double newTop, double newBottom) =>
      (newTop >= 0 && newBottom >= 0) && (height >= _size.minHeight);

  /// Return True if [newRight] and [newLeft] are bigger than zero or equal it
  /// and the [width] bigger than [minWidth] or equal it
  bool checkLeftRightMaxSize(double newLeft, double newRight) =>
      (newLeft >= 0 && newRight >= 0) && (width >= _size.minWidth);

  /// Calculate widget size by getting [top],[left],[bottom] and [right]
  void calculateWidgetSize({
    required double top,
    required double left,
    required double bottom,
    required double right,
  }) {
    width = _size.areaWidth - (left + right);
    height = _size.areaHeight - (top + bottom);
  }
}

class TriggerWidget extends StatefulWidget {
  final DragDetailsCallback onDrag;
  final Trigger trigger;

  const TriggerWidget({
    Key? key,
    required this.onDrag,
    required this.trigger,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return _TriggerWidgetState();
  }
}

class _TriggerWidgetState extends State<TriggerWidget> {
  double initX = 0;
  double initY = 0;

  void _handleDrag(DragStartDetails details) {
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;
  }

  void _handleUpdate(DragUpdateDetails details) {
    final double dx = details.globalPosition.dx - initX;
    final double dy = details.globalPosition.dy - initY;
    initX = details.globalPosition.dx;
    initY = details.globalPosition.dy;

    widget.onDrag(dx, dy);
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: widget.trigger.alignment,
      child: SizedBox(
        width: widget.trigger.width,
        height: widget.trigger.height,
        child: GestureDetector(
          behavior: HitTestBehavior.translucent,
          onPanStart: _handleDrag,
          onPanUpdate: _handleUpdate,
          child: widget.trigger.child,
        ),
      ),
    );
  }
}

class CommonSizes {
  CommonSizes({
    required this.areaHeight,
    required this.areaWidth,
    required this.height,
    required this.width,
    required this.minWidth,
    required this.minHeight,
    required this.initialPosition,
  });

  final double areaHeight;
  final double areaWidth;
  final double height;
  final double width;
  final double minWidth;
  final double minHeight;
  final Offset initialPosition;
}

class Trigger {
  late final Alignment alignment;
  final Widget child;
  final double? height;
  final double? width;
  final DragTriggersEnum dragTriggerType;

  Trigger({
    Alignment? alignment,
    this.height,
    this.width,
    required this.child,
    required this.dragTriggerType,
  }) {
    this.alignment = alignment ?? dragTriggerType.alignment;
  }
}
