import 'package:flutter/material.dart';
import 'package:okra_widget/models/Enums.dart';
import 'package:okra_widget/utils/OkraOptions.dart';
import 'package:webview_flutter/webview_flutter.dart';

class Web extends StatefulWidget {

  final OkraOptions okraOptions;

  const Web({
    Key key,
    this.okraOptions
  })  : assert(okraOptions != null), super(key: key);

  @override
  _WebState createState() => _WebState();
}


class _WebState extends State<Web> {

   Uri generateLinkInitializationUrl(OkraOptions okraOptions) {
     var queryParameters = {
       'isWebview': okraOptions.isWebview.toString(),
       'key': okraOptions.key,
       'token': okraOptions.token,
       'products': convertArrayListToString(okraOptions.products),
       'env': okraOptions.env.toString(),
       'clientName': okraOptions.clientName,
     };
     return Uri.https('demo-dev.okra.ng', '/link.html', queryParameters);
   }

   String convertArrayListToString(List<Product> productList){
     String formattedArray = "[";
     for (int index = 0; index < productList.length; index++){
       if(index == (productList.length - 1)){
         formattedArray = formattedArray + "\" ${productList[index]}\"";
       }else {
         formattedArray = formattedArray + "\"${productList[index]}\",";
       }
     }

     formattedArray = formattedArray + "]";

     return formattedArray.toString();
   }

//"https://demo-dev.okra.ng/link.html?isWebview=true&key=c81f3e05-7a5c-5727-8d33-1113a3c7a5e4&token=5d8a35224d8113507c7521ac&products=[%22auth%22,%22transactions%22,%22balance%22]&env=dev&clientName=Spinach"

  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl : generateLinkInitializationUrl(widget.okraOptions).toString(),
      javascriptMode : JavascriptMode.unrestricted,
      javascriptChannels: Set.from([
        JavascriptChannel(
            name: 'Mobile',
            onMessageReceived: (JavascriptMessage message) {
              Navigator.pop(context);
            })
      ]),
      onWebViewCreated: (webViewController){},
    );
  }
}
