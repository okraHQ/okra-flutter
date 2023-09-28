import 'package:client_information/client_information.dart';

class Helper {

  static Future<ClientInformation?> getDeviceInfo() async {
    try {
      return await ClientInformation.fetch();
    } catch (ex) {
      return null;
    }
  }

}
