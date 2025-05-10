import 'package:device_info_plus/device_info_plus.dart';
import 'package:get/get.dart';
import 'device_info_helper_stub.dart'
    if (dart.library.html) 'device_info_helper_web.dart';

class DeviceInfoHelper {
  static Future<(String deviceName, String osVersion)> getDeviceInfo() async {
    final DeviceInfoPlugin deviceInfo = DeviceInfoPlugin();

    if (GetPlatform.isAndroid) {
      final androidInfo = await deviceInfo.androidInfo;
      return (androidInfo.model ?? '', androidInfo.version.release ?? '');
    } else if (GetPlatform.isIOS) {
      final iosInfo = await deviceInfo.iosInfo;
      return (iosInfo.utsname.machine ?? '', iosInfo.systemVersion ?? '');
    } else if (GetPlatform.isWeb) {
      return getWebDeviceInfo(); // dipanggil dari file khusus Web
    } else {
      return ('Unknown Device', 'Unknown OS');
    }
  }
}
