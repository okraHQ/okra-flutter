import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class WalkThroughScreen extends StatefulWidget {
  @override
  _WalkThroughScreenState createState() => _WalkThroughScreenState();
}

class _WalkThroughScreenState extends State<WalkThroughScreen> {

  Widget dots (){
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        new Container(
           width: 10,
           height: 10,
           decoration: BoxDecoration(
             border: Border.all(color: Color.fromARGB(255, 230, 200, 80),width: 2),
             color: Color.fromARGB(255, 255, 255, 255),
             borderRadius: BorderRadius.circular(20),
           ),
         ),
        new SizedBox(width: 10,),
        new Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              color: Color.fromARGB(255, 235, 200, 80),
              borderRadius: BorderRadius.circular(20)
          ),
        ),
        new SizedBox(width: 10,),
        new Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(
              border: Border.all(color: Color.fromARGB(255, 230, 200, 80),width: 2),
              color: Color.fromARGB(255, 255, 255, 255),
              borderRadius: BorderRadius.circular(20)
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: new Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            new Text("Welcome to Carrot", style: TextStyle(fontSize: 25, fontWeight: FontWeight.w600),),
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
            new SizedBox(height: 15),
            dots(),
            new SizedBox(height: 30),
            new ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 250),
              child: new Text("Unleash the power of Okra and monitor all your banking activities and transaction in one place.", style: TextStyle(fontSize: 16),textAlign: TextAlign.center,),),
            new SizedBox(height: 50),
            new FlatButton(
                onPressed: (){}, color: Color.fromARGB(255, 235, 200, 80),
                child: new Text("Start your journey",
                  style: TextStyle(color: Colors.white),)
            )
          ],
        )


      ),
    );
  }
}
