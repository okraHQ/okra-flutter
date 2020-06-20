
import 'dart:core';

class Guarantor{
  int number;
  bool status;
  String message;

  Guarantor(bool status, String message, int number){
    this.status = status;
    this.message = message;
    this.number = number;
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'message': message,
      'number': number,
    };
  }
}
