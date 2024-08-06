import 'dart:async';

import 'package:flutter/material.dart';

class UiUtils {
  void showToast(BuildContext context, String message, Color color,
      {double? position, int? time, Color? textColor}) {
    OverlayEntry overlayEntry;
    overlayEntry = OverlayEntry(
      builder: (context) => Positioned(
        bottom: position ?? 60.0,
        width: MediaQuery.of(context).size.width - 48,
        left: 24,
        child: Material(
          color: Colors.transparent,
          child: Container(
            padding:
                const EdgeInsets.symmetric(horizontal: 24.0, vertical: 12.0),
            decoration: BoxDecoration(
              color: color,
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              message,
              style: TextStyle(color: textColor ?? Colors.white),
            ),
          ),
        ),
      ),
    );
    Overlay.of(context).insert(overlayEntry);
    Timer(
      Duration(seconds: time ?? 2),
      () {
        overlayEntry.remove();
      },
    );
  }
}