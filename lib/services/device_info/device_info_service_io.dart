import 'device_info_service.dart';

class IODeviceInfoService implements DeviceInfoService {
  @override
  String getDeviceName() => 'Unknown Device (Mobile)';

  @override
  String getOSVersion() => 'Unknown OS';
}

DeviceInfoService getDeviceInfoServiceImpl() => IODeviceInfoService();
