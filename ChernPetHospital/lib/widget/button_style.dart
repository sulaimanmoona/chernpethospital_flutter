import 'package:flutter/material.dart';

final ButtonStyle raisedButtonStyle = ElevatedButton.styleFrom(
  foregroundColor: Colors.white,
  backgroundColor: const Color.fromARGB(255, 46, 212, 241),
  minimumSize: const Size(88, 36),
  padding: const EdgeInsets.symmetric(horizontal: 50),
  shape: const RoundedRectangleBorder(
    borderRadius: BorderRadius.all(Radius.circular(2)),
  ),
);
