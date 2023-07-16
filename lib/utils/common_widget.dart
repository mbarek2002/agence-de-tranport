import 'package:admin_citygo/utils/images_strings.dart';
import 'package:flutter/material.dart';

class ImageContainer extends StatelessWidget {
  const ImageContainer({
    super.key,
     this.height,
    required this.child,
    this.margin,
    this.border,
    this.width
  });

  final double? height;
  final double? width;
  final Widget child;
  final EdgeInsetsGeometry? margin;
  final BorderRadiusGeometry? border;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(tSpalshImage),
            fit: BoxFit.fill
        ),
        borderRadius: border,
      ),
      child: child,
    );
  }
}
