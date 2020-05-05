# okra_widget

This is an flutter library for implementing okra widget

### Getting Started
This library would help you add Okra widget to your hybrid android/ios application in no time. All you need to do is ...

### Install
To use this plugin, add `okra_widget` as a [dependency in your pubspec.yaml file](https://flutter.io/platform-plugins/).
```pub
dependencies:
  okra_widget: ^0.0.1
```

### Usage
```dart
//Okra.create() static method takes in a context parameter and also and OkraOption parameter-->
 var okraOptions = new OkraOptions(true,"c81f3e05-7a5c-5727-8d33-1113a3c7a5e4","5d8a35224d8113507c7521ac",[Product.auth,Product.balance],Environment.dev,"Bassey");
 Okra.create(context, okraOptions);
```

## OkraOptions

|Name                   | Type           | Required            | Default Value       | Description         |
|-----------------------|----------------|---------------------|---------------------|---------------------|
|  `isWebview `         | `boolean`      | true                |  true               | 
|  `key `               | `String`       | true                |  undefined          | Your public key from Okra.
|  `token`              | `String`       | true                |  undefined          | Your pubic Key from Okra dashboard. Use test key for test mode and live key for live mode
|  `products`           | `ArrayList<Enums.Product>`| true     |  undefined          | The Okra products you want to use with the widget.
|  `env`                | `Enums.Environment`| true            |  undefined          | 
|  `clientName`         | `String`       | true                |  undefined          | Name of the customer using the widget on the application
|  `webhook`            | `String`       | true                |  undefined          | The Url that Okra send the client's data to.
