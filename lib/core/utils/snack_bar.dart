import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

SnackBar showSnackBar(
    {required BuildContext context, required String message, Color color = black}) {
  return SnackBar(
    content: GenericRichText(
      text: message,
      size: 12.sp,
      color: white,
      textAlign: TextAlign.start,
    ),
    backgroundColor: color,
    duration: const Duration(seconds: 3),
    showCloseIcon: true,
  );
}
  