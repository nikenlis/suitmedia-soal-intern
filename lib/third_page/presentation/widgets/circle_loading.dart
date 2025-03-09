
import 'package:flutter/material.dart';

import '../../../../core/theme.dart';

class CircleLoading extends StatelessWidget {
  const CircleLoading({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CircularProgressIndicator.adaptive(
        backgroundColor: greenColor,
      ),
    );
  }
}