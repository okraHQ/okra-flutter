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
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
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
                    "wema-bank"
                  ];

                  OkraOptions options = OkraOptions(
                      isWebview: true,
                      key: "101ee499-beed-53ef-b9e4-1846790792a5",
                      token: "5d8a35224d8113507c7521ac",
                      products: [Product.auth, Product.balance],
                      environment: "sandbox",
                      clientName: "Bassey");

                  options.guarantors = Guarantor(true, "", 2);
                  options.filter = Filter("all", banks);
                  OkraHandler reply = await Okra.create(context, options);
                }),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
