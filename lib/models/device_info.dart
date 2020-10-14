
import 'dart:core';

class DeviceInfo {

  String deviceName;
  String deviceModel;
  double longitude = 0;
  double latitude = 0;
  String platform;

  DeviceInfo(this.deviceName, this.deviceModel, this.latitude, this.longitude, this.platform);

  Map<String, dynamic> toJson() {
    return {
      'deviceName': deviceName.isNotEmpty ? deviceName : "",
      'deviceModel': deviceModel.isNotEmpty ? deviceModel : "",
      'longitude': longitude,
      'latitude': latitude,
      'platform': platform.isNotEmpty ? platform : ""
    };
  }
}
