import 'dart:core';

class OkraHandler {
  String? data;
  bool? isSuccessful;
  bool? hasError;
  bool? isDone;
  bool? onClose;

  OkraHandler(bool isDone, bool isSuccessful, bool hasError, bool onClose, String data){
    this.isDone = isDone;
    this.isSuccessful = isSuccessful;
    this.hasError = hasError;
    this.onClose = onClose;
    this.data = data;
  }
}
