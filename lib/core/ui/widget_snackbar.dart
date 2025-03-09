import 'package:another_flushbar/flushbar.dart';
import 'package:flutter/material.dart';
import 'package:suitmedia/core/theme.dart';

void showCustomSnackbar(BuildContext context, String message) {
  Flushbar(
    borderRadius: BorderRadius.circular(28),
    message: message,
    flushbarPosition: FlushbarPosition.TOP,
    backgroundColor: redColor,
    duration: const Duration(seconds: 2),
  ).show(context);
}