import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BankDetailScreen extends StatefulWidget {
  @override
  _BankDetailScreenState createState() => _BankDetailScreenState();
}

class _BankDetailScreenState extends State<BankDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new PreferredSize(child: new Container(
        padding: EdgeInsets.all(15),
        color: Colors.lightBlueAccent,
        child:  new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            new Text("Welcome To GTB", style: TextStyle(fontSize: 20, color: Colors.white70, fontWeight: FontWeight.w700),),
            new Text("Bassey Eshiett", style: TextStyle(fontSize: 20, color: Colors.white, fontWeight: FontWeight.w500),),
            new Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: <Widget>[
                new Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: <Widget>[
                    new Text("Your balance", style: TextStyle(fontSize: 14, color: Colors.white, fontWeight: FontWeight.w500),),
                    new Text("N200,000", style: TextStyle(fontSize: 25, color: Colors.white, fontWeight: FontWeight.w500),)
                  ],
                )
              ],
            )
          ],
        ),
      ), preferredSize: Size(double.infinity, 200)),
    );
  }
}
