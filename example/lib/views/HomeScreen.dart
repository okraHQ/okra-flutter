import 'package:example/components/BankCard.dart';
import 'package:flutter/material.dart';
import 'package:okra_widget/okra_widget.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: new Icon(Icons.subject, color: Color.fromARGB(255, 149, 131, 102), size: 40,),
        backgroundColor: Colors.transparent,
        elevation : 0,
      ),
      body: new ListView(
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: 15),
        children: <Widget>[
             new BankCard(),
             new BankCard()
        ],
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 0,
        backgroundColor: Color.fromARGB(255, 149, 131, 102),
        onPressed: (){
          callOkra(context);
        },
        child: Icon(Icons.add),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: BottomAppBar(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              new IconButton(icon: Icon(Icons.home), onPressed: (){}, color: Color.fromARGB(255, 149, 131, 102),),
              new IconButton(icon: Icon(Icons.settings), onPressed: (){}, color: Color.fromARGB(255, 149, 131, 102),),
            ],
          ),
          shape: CircularNotchedRectangle(),
          elevation: 24,
          color: Colors.white,
        ),
    );
  }
}

void callOkra(BuildContext context) async{
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
        key: "1ce5-58bf-af49-2d805fa8f798",
        token: "358130a943486f33dced",
        products: [Product.auth,
          Product.balance,
          Product.identity,
          Product.transactions],
        environment: "production-sandbox",
        clientName: "Carrot");
    options.color = "#9013FE";
    options.limit = "3";
    options.isCorporate = false;
    options.connectMessage = "Which account do you want to connect with?";
    options.callback_url = "";
    options.redirect_url = "";
    options.logo = "https://swipe.ng/assets/img/newswipe-logo-dark.svg";
    options.widget_success = "Your account was successfully linked to SwipeNG";
    options.widget_failed = "An unknown error occurred, please try again.";
    options.currency = "NGN";
    options.noPeriodic = true;
    options.exp = "";
    options.success_title = "null";
    options.success_message = "null";
    options.guarantors = new Guarantor(false,"""Carrot requires you to add guarantors""",1);
    options.filter = Filter("all", banks);
    OkraHandler reply = await Okra.create(context, options);
}