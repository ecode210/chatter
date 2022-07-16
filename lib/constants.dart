import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ChatterConstants {
  static Color priColor = const Color(0xFFBF40BF);
  static Color secColor = const Color(0xFF17011A);
  static void dialog(bool dismissable, Widget child) {
    Get.generalDialog(
      transitionDuration: const Duration(milliseconds: 200),
      barrierDismissible: dismissable,
      barrierLabel: "",
      barrierColor: Colors.black.withOpacity(0.5),
      pageBuilder: (context, animation, secondaryAnimation) {
        return const SizedBox();
      },
      transitionBuilder: (context, animation, secondaryAnimation, widget) {
        return Transform.scale(
          scale: animation.value,
          child: Opacity(
            opacity: animation.value,
            child: Dialog(
              backgroundColor: Colors.transparent,
              alignment: Alignment.center,
              elevation: 0,
              child: child,
            ),
          ),
        );
      },
    );
  }
}
