import 'package:example/models/Bank.dart';

class BankDetail {
  BankDetail();

  Bank bank = new Bank();
  double availableBalance;
  double ledgerBalance;
  String currency;
  String name;
  String nuban;
  String ref;
  String status;
  String type;
  String account;
  bool connected;

  factory BankDetail.fromJson(dynamic json) {
    BankDetail bankDetail = new BankDetail();
    bankDetail.availableBalance = json["available_balance"] + .0;
    bankDetail.ledgerBalance = json["ledger_balance"] + .0;
    bankDetail.currency = json["currency"];
    bankDetail.name = json["name"];
    bankDetail.nuban = json["nuban"];
    bankDetail.ref = json["ref"];
    bankDetail.status = json["status"];
    bankDetail.type = json["type"];
    bankDetail.account = json["account"];
    bankDetail.connected = json["connected"];
    return bankDetail;
  }
}