import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:flutter/material.dart';
import 'package:okra_widget_official/okra_widget.dart';
import 'dart:developer' as developer;

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(MyApp());
}

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

  void buildWithOptions() {
    var banks = [

      "first-bank-of-nigeria",
      "guaranty-trust-bank",
      "access-bank",

    ];

    Okra.buildWithOptions(context,
        key: "",
        token: "",
        color: "#3AB795",
        products: ['auth', 'identity', 'balance', 'transactions'],
        chargeAmount: 50000,
        authorization: true,
        chargeNote: "testing payment",
        chargeType: "one-time",
        chargeCurrency: "NGN",
        environment: "production",
        clientName: "Okra",
        logo: "https://dash.okra.ng/static/media/okra-logo.514fd943.png",
        limit: 3,
        meta: "Test Meta",
        options: {
          "name": "Flutter Options Test"
        },
        currency: "NGN",
        isCorporate: false,
        showBalance: true,
        geoLocation: true,
        payment: false,
        connectMessage:
        "Which account do you want to connect with?",
        callbackUrl: "",
        redirectUrl: "",
        // customerId: "64247efe8e3711362e9ef0ab",
        // reAuthAccountNumber: "1503274972",
        // reAuthBankSlug: "access-bank",
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
          developer.log('$data');
        }, onError: (message) {
          print("error");
          developer.log('$message');
        }, onClose: (message) {
          print("close");
          print(message);
        },
        onEvent: (message) {
          print("event");
          print(message);
        }
    );
  }

  void buildWithShortUrl() {
    Okra.buildWithShortUrl(
        context,
        shortUrl: dotenv.env['url']!,
        onSuccess: (data) {
          print("Success");
          developer.log('$data');
        },
        onError: ( message) {
          print("error");
          print(message);
        },
        onClose: (message) {
          print("close");
          print(message);
        },
        onEvent: (message) {
          print("event");
          print(message);
        }
    );
  }
  @override
  Widget build(BuildContext context) {
    final ButtonStyle buttonStyle = ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.green,)
    );
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
            SizedBox(height: 40),
            ElevatedButton(
                child: Text(
                  "Build With Options",
                  style: TextStyle(color: Colors.white),
                ),
                style: buttonStyle,
                onPressed: () async {
                  buildWithOptions();
                }),
            SizedBox(height: 20),
            ElevatedButton(
                child: Text(
                  "Build With ShortUrl",
                  style: TextStyle(color: Colors.white),
                ),
                style: buttonStyle,
                onPressed: () async {
                  buildWithShortUrl();
                }),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
