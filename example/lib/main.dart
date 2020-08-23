import 'package:example/views/WalkThroughScreen.dart';
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
      home: WalkThroughScreen(),//MyHomePage(title: 'Okra Test Widget'),
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
                      key: "1ce5-58bf-af49-2d805fa8f798",
                      token: "358130a943486f33dced",
                      products: [Product.auth,
                        Product.balance,
                        Product.identity,
                        Product.transactions],
                      environment: "production-sandbox",
                      clientName: "Bassey");
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
                  options.guarantors = new Guarantor(false,"""SwipeNG requires you to add guarantors""",1);
                  options.filter = Filter("all", banks);
                  OkraHandler reply = await Okra.create(context, options);
                  print("-----------------------------------------------");
                  print(reply.isSuccessful);
                  print(reply.data);
                }),
          ],
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
