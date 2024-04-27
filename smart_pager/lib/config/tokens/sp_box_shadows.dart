import 'package:flutter/material.dart';

class SPShadows {
  static List<BoxShadow> shadow1 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      offset: const Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      offset: const Offset(0, 1),
      blurRadius: 3,
      spreadRadius: 1,
    ),
  ];
  static List<BoxShadow> shadow2 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      offset: const Offset(0, 1),
      blurRadius: 2,
      spreadRadius: 0,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      offset: const Offset(0, 2),
      blurRadius: 6,
      spreadRadius: 2,
    ),
  ];
  static List<BoxShadow> shadow3 = [
    BoxShadow(
      color: Colors.black.withOpacity(0.15),
      offset: const Offset(0, 8),
      blurRadius: 12,
      spreadRadius: 6,
    ),
    BoxShadow(
      color: Colors.black.withOpacity(0.3),
      offset: const Offset(0, 4),
      blurRadius: 4,
      spreadRadius: 0,
    ),
  ];
}
