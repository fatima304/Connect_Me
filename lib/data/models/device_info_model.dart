import 'package:device_info_plus/device_info_plus.dart';

// Model for device information
class DeviceInfoModel {
  final String modelName;
  final String osVersion;

  const DeviceInfoModel({required this.modelName, required this.osVersion});
  // Convert Android device information into the app model.
  factory DeviceInfoModel.fromAndroidDeviceInfo(AndroidDeviceInfo info) {
    return DeviceInfoModel(
      modelName: info.model,
      osVersion: info.version.release,
    );
  }
  // Convert iOS device information into the app model.
  factory DeviceInfoModel.fromIosDeviceInfo(IosDeviceInfo info) {
    return DeviceInfoModel(
      modelName: info.model,
      osVersion: info.systemVersion,
    );
  }
}
