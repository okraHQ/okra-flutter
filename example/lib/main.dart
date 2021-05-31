import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:okra_widget/models/okra_handler.dart';
import 'package:okra_widget/okra.dart';
import 'package:okra_widget/okra_widget.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Okra Link Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Okra Test Widget'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {


  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Click button to open Okra Widget'),
            RaisedButton(
                color: Colors.green,
                child: Text(
                  "Click me",
                  style: TextStyle(color: Colors.white),
                ),
                onPressed: () async {
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
                    "wema-bank",
                    "rubies-bank",
                    "kuda-bank"
                  ];


                  var okraOptions = {
                    "key": "key",
                    "token": "token",
                    "products": [
                      "auth",
                      "balance",
                      "identity",
                      "transactions"
                    ],
                    "env": "production",
                    "clientName": "Bassey",
                    "color" : "#9013FE",
                    "limit" : "3",
                    "isCorporate" : false,
                    "ussd" : true,
                    "payment" : true,
                    "charge": {
                      "type":"one-time",
                      "amount":"10000",
                      "note":"",
                       "currency": "NGN",
                       "account": "5f450b2689a23801307c8b5b"
                    },
                    "connectMessage" : "Which account do you want to connect with?",
                    "callback_url" : "",
                    "redirect_url" : "",
                    "logo" : "https://dash.okra.ng/static/media/okra-logo.514fd943.png",
                    "widget_success" : "Your account was successfully linked to SwipeNG",
                    "widget_failed" : "An unknown error occurred, please try again.",
                    "currency" : "NGN",
                    "noPeriodic" : true,
                    "exp" : "",
                    "success_title" : "null",
                    "success_message" : "null",
                    "guarantors" : {
                      "status": false,
                      "message": "Okra requires you to add guarantors",
                      "number": 3,
                    },
                    "filter" : {
                      "industry_type": "all",
                      "banks": banks
                    }
                  };

                  OkraHandler reply = await Okra.create(context, okraOptions);
                }),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
