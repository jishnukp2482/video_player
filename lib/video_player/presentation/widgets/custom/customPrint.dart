import 'package:flutter/foundation.dart';

customPrint(String message) {
  if (!kReleaseMode) {
    return debugPrint("$message");
  }
}

void successPrint(String message) {
  if (!kReleaseMode) {
    return debugPrint("\x1B[32m$message\x1B[0m");
  }
}

void errorPrint(String message) {
  if (!kReleaseMode) {
    return debugPrint("\x1B[31m$message\x1B[0m");
  }
}

void warningPrint(String message) {
  if (!kReleaseMode) {
    return debugPrint("\x1B[33m$message\x1B[0m");
  }
}

void alertPrint(String message) {
  if (!kReleaseMode) {
    return debugPrint("\x1B[34m$message\x1B[0m");
  }
}
