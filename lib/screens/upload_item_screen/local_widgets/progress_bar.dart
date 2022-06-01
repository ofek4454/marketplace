import 'dart:math';

import 'package:flutter/material.dart';

class ProgressBar extends StatelessWidget {
  final double? progress;
  const ProgressBar({@required this.progress, Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return AnimatedContainer(
      duration: const Duration(milliseconds: 500),
      margin: const EdgeInsets.symmetric(horizontal: 10),
      width: max(progress! * (size.width - 40) / 100, 20),
      height: 20,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.amber,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Text(
        '${progress!.toInt()}%',
        textAlign: TextAlign.center,
        style: const TextStyle(
          fontFamily: 'Lato',
          fontSize: 15,
        ),
      ),
    );
  }
}
