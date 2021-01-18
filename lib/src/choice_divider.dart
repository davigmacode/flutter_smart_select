export 'package:flutter/material.dart' show Divider;

// import 'package:flutter/material.dart';

// /// Default divider widget
// class S2Divider extends StatelessWidget {

//   /// Divider color
//   final Color color;

//   /// Divider thickness
//   final double thickness;

//   /// Divider spacing
//   final double spacing;

//   /// Default constructor
//   const S2Divider({
//     Key key,
//     this.color,
//     this.thickness,
//     this.spacing,
//   }) : super(key: key);

//   /// Default color of the divider widget
//   static const Color defaultColor = const Color(0xFFEEEEEE);

//   /// Default spacing of the divider widget
//   static const double defaultSpacing = 4.0;

//   /// Default thickness of the divider widget
//   static const double defaultThickness = 0.5;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: EdgeInsets.symmetric(
//         vertical: spacing ?? S2Divider.defaultSpacing
//       ),
//       child: SizedBox(
//         height: thickness ?? S2Divider.defaultThickness,
//         child: DecoratedBox(
//           decoration: BoxDecoration(
//             border: Border(
//               bottom: BorderSide(
//                 color: color ?? Theme.of(context).dividerColor,
//                 width: thickness ?? S2Divider.defaultThickness,
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
