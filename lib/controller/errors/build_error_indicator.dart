import 'package:flutter/material.dart';

buildErrorIndicator(dynamic error) {
  return Center(
    child: Text('Error: $error'),
  );
}
