import 'dart:core';

class OkraHandler {
  String data;
  bool isSuccessful;
  bool hasError;
  bool isDone;

  OkraHandler(bool isDone, bool isSuccessful, bool hasError, String data){
    this.isDone = isDone;
    this.isSuccessful = isSuccessful;
    this.hasError = hasError;
    this.data = data;
  }
}
