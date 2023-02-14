String mBuildOkraWidgetWithOptions(final Map<String, dynamic> okraOptions) =>
    '''
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Okra React Native SDK</title>
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
              }
              })
          }
      </script>
    </body>
</html>
''';

String buildOkraWidgetWithShortUrl(final String shortUrl) => '''
<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Okra React Native SDK</title>
  </head>
    <body onload="buildWithShortUrl()" style="background-color:#fff;height:100vh">
      <script src="https://cdn.okra.ng/v2/bundle.js"></script>
      <script type="text/javascript">
          window.onload = buildWithOptions;
          function buildWithShortUrl(){
              Okra.buildWithShortUrl({
                short_url: '$shortUrl',
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
                }
            })
          }
      </script>
    </body>
</html>
''';
