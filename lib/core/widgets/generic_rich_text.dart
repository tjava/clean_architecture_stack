import 'package:flutter/material.dart';

class GenericRichText extends StatelessWidget {
  final String text;
  final double? size;
  final double? lineHeight;
  final int? maxLines;
  final Color? color;
  final FontWeight? weight;
  final TextAlign? textAlign;

  const GenericRichText({
    super.key,
    required this.text,
    this.size,
    this.lineHeight,
    this.maxLines,
    this.color,
    this.weight,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    return RichText(
      textAlign: textAlign ?? TextAlign.center,
      maxLines: maxLines ?? 100,
      overflow: TextOverflow.ellipsis,
      text: TextSpan(
        text: text,
        style: TextStyle(
          height: lineHeight,
          color: color ?? grey,
          fontSize: size ?? 16,
          fontWeight: weight ?? FontWeight.w400,
        ),
      ),
    );
  }
}
  