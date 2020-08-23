import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WalkThroughScreen extends StatefulWidget {
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Welcome to Carrot"),
            new SizedBox(height: 50),
            new Container(
              width: double.infinity,
              height: 200,
              child: new PageView(
                children: <Widget>[
                  Image.asset("asset/images/finance.png"),
                  Image.asset("asset/images/calculator.png"),
                  Image.asset("asset/images/transaction.png"),
                ],
              ),
            ),
            new SizedBox(height: 50),
            new ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 250),
              child: new Text("Unleash the power of Okra and monitor all your banking activities"),),
            new FlatButton(
                onPressed: (){}, color: Colors.orangeAccent,
                child: new Text("Start your journey",
                  style: TextStyle(color: Colors.white),)
            )
          ],
        )


      ),
    );
  }
}
