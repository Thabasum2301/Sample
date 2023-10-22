// import 'package:flutter/material.dart';
// // import 'package:info_popup/info_popup.dart';
//
// void main() => runApp(const MyApp());
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//       home: InfoPopupPage(),
//     );
//   }
// }
//
// class InfoPopupPage extends StatefulWidget {
//   const InfoPopupPage({super.key});
//
//   @override
//   State<InfoPopupPage> createState() => _InfoPopupPageState();
// }
//
// class _InfoPopupPageState extends State<InfoPopupPage> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Align(
//         child: SingleChildScrollView(
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.end,
//             children: [
//               InfoPopupWidget(
//                 arrowTheme: InfoPopupArrowTheme(
//                   color: Colors.black87,
//                   arrowDirection: ArrowDirection.up,
//                 ),
//                 customContent: Container(
//                   decoration: BoxDecoration(
//                     color: Colors.white,
//                     boxShadow: [
//                       BoxShadow(
//                         color: Colors.grey.withOpacity(0.6),
//                         spreadRadius: 5,
//                         blurRadius: 5,
//                         offset: Offset(0, 7), // changes position of shadow
//                       ),
//                     ],
//                     borderRadius: BorderRadius.circular(10),
//                   ),
//                   child: Column(children: [
//                     Wrap(
//                       spacing: 24,
//                       runSpacing: 24,
//                       alignment: WrapAlignment.start,
//                       crossAxisAlignment: WrapCrossAlignment.start,
//                       children: removeSizedBox([
//                         _iconButton(
//                             child: Icon(Icons.event_seat,
//                                 size: 30, color: Colors.purple),
//                             title: 'Seat Walk-in',
//                             onTap: () {}),
//                         _iconButton(
//                             child: Icon(Icons.edit_calendar,
//                                 size: 30, color: Colors.purple),
//                             title: 'Make Reservation',
//                             onTap: () {}),
//                         _iconButton(
//                             child: IconWidget(
//                                 iconData: Icons.more_time,
//                                 type: IconType.onlyIcon,
//                                 iconColor: Colors.purple),
//                             title: 'Add WaitList',
//                             onTap: () {}),
//                         _iconButton(
//                             child: IconWidget(
//                                 iconData: Icons.block_sharp,
//                                 type: IconType.onlyIcon,
//                                 iconColor: Colors.purple),
//                             title: 'Block Table',
//                             onTap: () {})
//                       ]),
//                     )
//                   ]),
//                 ),
//                 child: Text('Table 001'),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   static _iconButton(
//       {required Widget child,
//       required String title,
//       required Function() onTap}) {
//     return InkWell(
//       splashColor: Colors.transparent,
//       highlightColor: Colors.transparent,
//       onTap: onTap,
//       child: Column(children: [
//         SizedBox(height: 36, width: 36, child: FittedBox(child: child)),
//         Text(title)
//       ]),
//     );
//   }
// }
//
// class IconWidget extends StatelessWidget {
//   final Color? color;
//   final Color? iconColor;
//   final IconData iconData;
//   final Function()? onPressed;
//   final IconType type;
//   final double iconSize;
//
//   const IconWidget(
//       {Key? key,
//       required this.iconData,
//       this.color = Colors.white,
//       this.iconColor = Colors.grey,
//       this.onPressed,
//       this.type = IconType.iconButton,
//       this.iconSize = 24})
//       : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     if (onPressed == null) {
//       return IgnorePointer(child: _buildIcon());
//     }
//
//     return _buildIcon();
//   }
//
//   Widget _buildIcon() {
//     switch (type) {
//       case IconType.onlyIcon:
//         return InkWell(
//           highlightColor: Colors.transparent,
//           splashColor: Colors.transparent,
//           onTap: onPressed ?? () {},
//           child: Icon(
//             iconData,
//             size: iconSize,
//             color: iconColor,
//           ),
//         );
//       case IconType.iconButton:
//         return IconButton(
//             padding: EdgeInsets.zero,
//             icon: Icon(
//               iconData,
//               color: iconColor,
//               size: iconSize,
//             ),
//             onPressed: onPressed ?? () {});
//       case IconType.circular:
//         return MaterialButton(
//           onPressed: onPressed ?? () {},
//           color: color,
//           textColor: iconColor,
//           minWidth: 0,
//           height: 0,
//           padding: EdgeInsets.all(16),
//           shape: CircleBorder(),
//           child: Icon(
//             iconData,
//             size: iconSize,
//           ),
//         );
//     }
//   }
// }
//
// List<Widget> removeSizedBox(List<Widget> children) {
//   var widgets = <Widget>[];
//   for (var widget in children) {
//     if (widget is SizedBox) {
//     } else {
//       widgets.add(widget);
//     }
//   }
//   return widgets;
// }
//
// enum IconType { onlyIcon, iconButton, circular }
