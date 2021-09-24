import 'package:flutter/material.dart';
import 'package:places/res/colors.dart';

class Indicator extends StatelessWidget {
  final int positionIndex;
  final int currentIndex;

  const Indicator({
    required this.currentIndex,
    required this.positionIndex,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      height: 8,
      width: positionIndex == currentIndex ? 24 : 8,
      decoration: BoxDecoration(
        color: positionIndex == currentIndex ? lmGreenColor : Colors.grey,
        borderRadius: BorderRadius.circular(100),
      ),
      duration: const Duration(milliseconds: 200),
    );
  }
}
