import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:okra_widget/okra_widget.dart';

void main() {
  const MethodChannel channel = MethodChannel('okra_widget');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await OkraWidget.platformVersion, '42');
  });
}
