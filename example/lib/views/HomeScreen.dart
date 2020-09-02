import 'dart:convert';

import 'package:example/components/BankCard.dart';
import 'package:example/models/Bank.dart';
import 'package:example/models/BankDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okra_widget/okra_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<BankDetail> listOfBankDetail = new List();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: <Widget>[
        Container(),
        Scaffold(
          appBar: AppBar(
            leading: new IconButton(icon: new Icon(
              Icons.subject,
              color: Color.fromARGB(255, 149, 131, 102),
              size: 40,
            ), onPressed: (){

            }),
            backgroundColor: Colors.transparent,
            elevation: 0,
          ),
          body: new ListView.builder(
            padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
            itemCount: listOfBankDetail.length,
            itemBuilder: (BuildContext context, int index) {
              return BankCard(listOfBankDetail[index]);
            },
          ),
          floatingActionButton: FloatingActionButton(
            elevation: 0,
            backgroundColor: Color.fromARGB(255, 149, 131, 102),
            onPressed: () async {
              //callOkra(context);
              var banks = [
                "ecobank-nigeria",
                "fidelity-bank",
                "first-bank-of-nigeria",
                "first-city-monument-bank",
                "guaranty-trust-bank",
                "access-bank",
                "unity-bank",
                "alat",
                "polaris-bank",
                "stanbic-ibtc-bank",
                "standard-chartered-bank",
                "sterling-bank",
                "union-bank-of-nigeria",
                "united-bank-for-africa",
                "wema-bank"
              ];

              OkraOptions options = OkraOptions(
                  isWebview: true,
                  key: "b7704b61-1ce5-58bf-af49-2d805fa8f798",
                  token: "5da6358130a943486f33dced",
                  products: [
                    Product.auth,
                    Product.balance,
                    Product.identity,
                    Product.transactions
                  ],
                  environment: "production-sandbox",
                  clientName: "Carrot");
              options.color = "#9013FE";
              options.limit = "3";
              options.isCorporate = false;
              options.connectMessage =
                  "Which account do you want to connect with?";
              options.callback_url = "";
              options.redirect_url = "";
              options.logo =
                  "https://swipe.ng/assets/img/newswipe-logo-dark.svg";
              options.widget_success =
                  "Your account was successfully linked to SwipeNG";
              options.widget_failed =
                  "An unknown error occurred, please try again.";
              options.currency = "NGN";
              options.noPeriodic = true;
              options.exp = "";
              options.success_title = "null";
              options.success_message = "null";
              options.guarantors = new Guarantor(
                  false, """Carrot requires you to add guarantors""", 1);
              options.filter = Filter("all", banks);
              OkraHandler reply = await Okra.create(context, options);
              print(reply.data);
              var parsedJson = json.decode(reply.data);
              print("----------------------------------------------------");
              print(parsedJson["balance"]["data"]["formatted"]);
              print("----------------------------------------------------");
              print(parsedJson["balance"]["data"]["formatted"][0]);
              print("----------------------------------------------------");
              var recordId = parsedJson["record_id"];
              var bankJson = await loadBankJsonFromAsset();
              var parsedBankJson = json.decode(bankJson);
              var bankList = parseBank(parsedBankJson["banks"]);
              var foundBank = getBankById(parsedJson["bank_id"], bankList);
              listOfBankDetail.addAll(parseBalance(
                  foundBank, parsedJson["balance"]["data"]["formatted"]));
              setState(() {});
            },
            child: Icon(Icons.add),
          ),
        )
      ],
    );
  }
}

void callOkra(BuildContext context) async {}

Future<String> loadBankJsonFromAsset() async {
  return await rootBundle.loadString("asset/jsons/banks.json");
}

List<Bank> parseBank(dynamic json) {
  List<Bank> banks = new List();
  for (var index = 0; index <= 20; index++) {
    try {
      var tempJson = json[index];
      var parsedBank = Bank.fromJson(tempJson);
      banks.add(parsedBank);
    } catch (exception) {
      break;
    }
  }
  return banks;
}

Bank getBankById(String id, List<Bank> banks) {
  return banks.singleWhere((bank) => bank.id == id);
}

List<BankDetail> parseBalance(Bank bank, dynamic json) {
  List<BankDetail> listOfBankDetail = new List();
  for (var index = 0; index <= 10; index++) {
    try {
      var tempJson = json[index];
      var parsedBankDetail = BankDetail.fromJson(tempJson);
      parsedBankDetail.bank = bank;
      listOfBankDetail.add(parsedBankDetail);
    } catch (exception) {
      break;
    }
  }
  return listOfBankDetail;
}

void parseIdentity(dynamic json) async {}
