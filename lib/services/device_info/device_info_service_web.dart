import 'dart:html' as html;
import 'device_info_service.dart';

class WebDeviceInfoService implements DeviceInfoService {
  @override
  String getDeviceName() => html.window.navigator.appName ?? '';

  @override
  String getOSVersion() => html.window.navigator.userAgent ?? '';
}

DeviceInfoService getDeviceInfoServiceImpl() => WebDeviceInfoService();
