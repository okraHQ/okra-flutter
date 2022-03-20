import 'dart:core';

class OkraHandler {
  String? data;
  bool? isSuccessful;
  bool? hasError;
  bool? isDone;
  bool? onClose;
  bool? beforeClose;

  OkraHandler(bool isDone, bool isSuccessful, bool hasError, bool onClose,
      bool beforeClose, String data) {
    this.isDone = isDone;
    this.isSuccessful = isSuccessful;
    this.hasError = hasError;
    this.onClose = onClose;
    this.beforeClose = beforeClose;
    this.data = data;
  }

  String? get successData => this.data;
}
