import 'package:example/models/BankDetail.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';

class BankCard extends StatefulWidget {
  final BankDetail bankDetail;
  BankCard(this.bankDetail);
  @override
  _BankCardState createState() => _BankCardState();
}

class _BankCardState extends State<BankCard> {
  @override
  Widget build(BuildContext context) {
    return new GestureDetector(
      onTap: (){
        Navigator.pushNamed(context, '/details');
      },
      child: new Container(
        margin: EdgeInsets.only(bottom: 20),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.5),
                spreadRadius: 2,
                blurRadius: 3,
                offset: Offset(0, 2), // changes position of shadow
              ),
            ],
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [Colors.redAccent, Colors.red])),
        child: new SizedBox(
            height: 120,
            child: new Padding(
              padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
              child: new Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  new SvgPicture.asset("asset/images/gtbank.svg", width: 100,),
                  new Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      new Text("GT Bank", style: TextStyle(color: Colors.white, fontSize: 18, fontWeight: FontWeight.bold),),
                      new Text(
                          widget.bankDetail != null ? "${widget.bankDetail.nuban} - ${widget.bankDetail.type}" : "",
                          style: TextStyle(color: Colors.white, fontSize: 14,)),
                      new Text(
                          widget.bankDetail != null ? widget.bankDetail.availableBalance.toString() : "",
                          style: TextStyle(color: Colors.white, fontSize: 14,),
                      ),
                    ],
                  ),
                ],
              )
            )
        ),
      ),
    );
  }
}
