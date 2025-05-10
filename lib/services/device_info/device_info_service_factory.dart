import 'device_info_service.dart'
    if (dart.library.html) 'device_info_service_web.dart'
    if (dart.library.io) 'device_info_service_io.dart';
import 'device_info_service_io.dart';

DeviceInfoService getDeviceInfoService() => getDeviceInfoServiceImpl();
