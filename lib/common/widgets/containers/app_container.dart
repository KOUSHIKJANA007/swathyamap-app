import 'package:flutter/material.dart';

class AppContainer extends StatelessWidget {
  const AppContainer({
    super.key,
    this.borderRadius = 0.0,
    this.child,
    this.color,
    this.boxShadow,
    this.padding,
    this.margin,
    this.height,
    this.width, this.onTap, this.border, this.clip=Clip.none, this.constraints, this.image, this.onTapDown,
  });

  final double borderRadius;
  final Widget? child;
  final Color? color;
  final List<BoxShadow>? boxShadow;
  final EdgeInsets? padding;
  final EdgeInsets? margin;
  final double? height;
  final double? width;
  final VoidCallback? onTap;
  final Function(TapDownDetails)? onTapDown;
  final BoxBorder? border;
  final Clip clip;
  final BoxConstraints? constraints;
  final DecorationImage? image;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      onTapDown: onTapDown,
      child: Container(
        padding: padding,
        margin: margin,
        height: height,
        width: width,
        clipBehavior: clip,
        constraints: constraints,
        decoration: BoxDecoration(
          image: image,
          borderRadius: BorderRadius.circular(borderRadius),
          border: border,
          color: color,
          boxShadow: boxShadow,
        ),
        child: child,
      ),
    );
  }
}
