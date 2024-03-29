
String mBuildOkraWidgetWithOptions(final Map<String, dynamic> okraOptions) =>
    '''
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Okra Flutter SDK</title>
  </head>
    <body onload="buildWithOptions()" style="background-color:#fff;height:100vh">
      <script src="https://cdn.okra.ng/v2/bundle.js"></script>
      <script type="text/javascript">
          window.onload = buildWithOptions;
          function buildWithOptions(){
              Okra.buildWithOptions({
                name: '${okraOptions["clientName"]}',
                env: '${okraOptions["env"]}',
                key: '${okraOptions["key"]}',
                token: '${okraOptions["token"]}',
                products: ${okraOptions["products"]},
                logo: '${okraOptions["logo"]}',
                payment: ${okraOptions["payment"]},
                color: '${okraOptions["color"]}',
                filter: ${okraOptions["filters"]},
                meta: '${okraOptions["meta"]}',
                options: ${okraOptions["options"]},
                isCorporate: ${okraOptions["isCorporate"]},
                showBalance: ${okraOptions["showBalance"]},
                geoLocation: ${okraOptions["geoLocation"]},
                multi_account: ${okraOptions["multiAccount"]},
                limit: ${okraOptions["limit"]},
                callback_url: '${okraOptions["callback_url"]}',
                connectMessage: '${okraOptions["connectMessage"]}',
                currency: '${okraOptions["currency"]}',
                widget_success: '${okraOptions["widget_success"]}',
                widget_failed: '${okraOptions["widget_failed"]}',
                guarantors: ${okraOptions["guarantors"]},
                exp: '${okraOptions["exp"]}',
                charge: ${okraOptions["charge"]},
                customer: ${okraOptions["customer"]},
                deviceInfo: ${okraOptions["charge"]},
                reauth_account: '${okraOptions["reauth_account"]}',
                reauth_bank: '${okraOptions["reauth_bank"]}',
                onSuccess: function(data){
                      let response = {event:'option success', data}
                      window.FlutterOnSuccess.postMessage(JSON.stringify(response))
                  },
                onClose: function(){
                      let response = {event:'option close'}
                      window.FlutterOnClose.postMessage(JSON.stringify(response))
                  },
                  BeforeClose: function(){
                    let response = {event:'option before close'}
                    window.FlutterBeforeClose.postMessage(JSON.stringify(response))
                },
                onError: function(data){
                  let response = {event:'option error', data}
                  window.FlutterOnError.postMessage(JSON.stringify(response))
                },
                onEvent: function(data){
                  let response = {event:'option event', data}
                  window.FlutterOnEvent.postMessage(JSON.stringify(response))
                }
              })
          }
      </script>
    </body>
</html>
''';

String buildOkraWidgetWithShortUrl(final String? shortUrl, dynamic deviceInfo) => '''
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Okra Flutter SDK</title>
  </head>
    <body onload="buildWithShortUrl()" style="background-color:#fff;height:100vh">
      <script src="https://cdn.okra.ng/v2/bundle.js"></script>
      <script type="text/javascript">
          window.onload = buildWithShortUrl;
          function buildWithShortUrl(){
              Okra.buildWithShortUrl({
                short_url: '$shortUrl',
                deviceInfo: '$deviceInfo',
                onSuccess: function(data){
                    let response = {event:'option success', data}
                    window.FlutterOnSuccess.postMessage(JSON.stringify(response)) 
                },
                onClose: function(){
                    let response = {event:'option close'}
                    window.FlutterOnClose.postMessage(JSON.stringify(response))
                },
                BeforeClose: function(){
                  let response = {event:'option before close'}
                  window.FlutterBeforeClose.postMessage(JSON.stringify(response))
                },
                onError: function(data){
                  let response = {event:'option error', data}
                  window.FlutterOnError.postMessage(JSON.stringify(response))
                },
                onEvent: function(data){
                  let response = {event:'option event', data}
                  window.FlutterOnEvent.postMessage(JSON.stringify(response))
                }
            })
          }
      </script>
    </body>
</html>
''';
