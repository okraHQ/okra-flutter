import 'dart:convert';

import 'package:flutter/material.dart';
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

                  Okra.buildWithOptions(context,
                      key: "3f52ee9d-f081-55a7-a9d8-73d4b5878bd2",
                      token: "5da6358130a943486f33dced",
                      color: "#3AB795",
                      products: ['auth', 'identity', 'balance', 'transactions'],
                      chargeAmount: 1000,
                      chargeNote: "testing",
                      chargeType: "one-time",
                      chargeCurrency: "NGN",
                      environment: "production",
                      clientName: "clientName",
                      customerBvn: "22188789177",
                      logo:
                          "https://dash.okra.ng/static/media/okra-logo.514fd943.png",
                      limit: 3,
                      currency: "NGN",
                      isCorporate: false,
                      showBalance: true,
                      geoLocation: true,
                      payment: false,
                      connectMessage:
                          "Which account do you want to connect with?",
                      callbackUrl: "",
                      redirectUrl: "",
                      widgetSuccess:
                          "Your account was successfully linked to SwipeNG",
                      widgetFailed:
                          "An unknown error occurred, please try again.",
                      guarantors: {
                        "status": false,
                        "message": "Okra requires you to add guarantors",
                        "number": 3,
                      },
                      filters: {"industry_type": "all", "banks": banks},
                      onSuccess: (data) {
                    print("Success");
                    print(data);
                  }, onError: (message) {
                    print("error");
                    print(message);
                  }, onClose: (message) {
                    print("close");
                    print(message);
                  });
                  // Okra.buildWithShortUrl(
                  //     context,
                  //     shortUrl: "ns_aIEz8r",
                  //     onSuccess: (data) {
                  //       print("Success");
                  //       print(data);
                  //     },
                  //     onError: ( message) {
                  //       print("error");
                  //       print(message);
                  //     },
                  //     onClose: (message) {
                  //       print("close");
                  //       print(message);
                  //     }
                  // );
                }),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
