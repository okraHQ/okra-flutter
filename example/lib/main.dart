import 'package:flutter/material.dart';
import 'package:okra_widget/Okra.dart';
import 'package:okra_widget/models/Enums.dart';
import 'package:okra_widget/models/Guarantor.dart';
import 'package:okra_widget/models/Filter.dart';
import 'package:okra_widget/models/OkraHandler.dart';
import 'package:okra_widget/utils/OkraOptions.dart';

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

        child: new Column(

          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Click button to open Okra Widget'),
            new RaisedButton(
              color: Colors.green,
              child: new Text("Click me", style: TextStyle(
                color: Colors.white
              ),),
              onPressed: () async {
                var banks = ["ecobank-nigeria", "fidelity-bank", "first-bank-of-nigeria", "first-city-monument-bank", "guaranty-trust-bank", "access-bank","unity-bank","alat", "polaris-bank","stanbic-ibtc-bank","standard-chartered-bank","sterling-bank","union-bank-of-nigeria","united-bank-for-africa","wema-bank"];
                var option = new OkraOptions(true,"101ee499-beed-53ef-b9e4-1846790792a5","5da6358130a943486f33dced",[Product.auth,Product.balance],Environment.production,"Bassey");
                option.guarantors = new Guarantor(true, "", 2);
                option.filter = new Filter("all", banks);
                OkraHandler reply = await Okra.create(context, option);
              },
            )
          ],
        ),
      ),
       // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
