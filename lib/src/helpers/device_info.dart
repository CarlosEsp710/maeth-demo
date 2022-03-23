part of 'helpers.dart';

Future<String> deviceName() async {
  DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

  late String deviceName;

  if (Platform.isAndroid) {
    AndroidDeviceInfo androidInfo = await deviceInfo.androidInfo;
    deviceName = androidInfo.model;
  } else if (Platform.isIOS) {
    IosDeviceInfo iosInfo = await deviceInfo.iosInfo;
    deviceName = iosInfo.model;
  }

  return deviceName.toString();
}
