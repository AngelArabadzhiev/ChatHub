import 'dart:ui';
import 'package:flutter/material.dart';



class GlassBox extends StatelessWidget {
  final double width;
  final  double height;
  const GlassBox({super.key, required this.height, required this.width});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.only(topLeft: Radius.circular(59), topRight: Radius.circular(59)),
      child: SizedBox(
        width: width,
        height: height,
        child: Stack(
          children: [
            BackdropFilter(filter: ImageFilter.blur(
              sigmaX: 10,
              sigmaY: 10
            ),child: Container(
              decoration: BoxDecoration(gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white.withOpacity(0.08),
                  Colors.grey.withOpacity(0.15),
                  Colors.black38.withOpacity(0.1),

                ],
              )),
            ) ,
            ),
          ],
        ),
      ),
    );
  }
}
