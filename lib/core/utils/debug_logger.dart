import 'package:flutter/material.dart';

void dPrint(dynamic message, {String? tag}) {
  debugPrint("🔍 [${tag ?? "DEBUG"}] $message");
}
