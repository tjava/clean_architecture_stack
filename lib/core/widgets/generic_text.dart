import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GenericText extends StatelessWidget {
  final String text;
  final double? size;
  final Color? color;
  final FontWeight? weight;
  final TextOverflow? overflow;

  const GenericText({
    super.key,
    required this.text,
    this.size,
    this.color,
    this.weight,
    this.overflow,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: TextStyle(
        fontSize: size ?? 16.sp,
        color: color ?? Colors.black,
        fontWeight: weight ?? FontWeight.normal,
      ),
      overflow: overflow ?? TextOverflow.ellipsis,
    );
  }
}
  