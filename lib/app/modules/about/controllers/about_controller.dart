import 'package:get/get.dart';
import 'package:package_info_plus/package_info_plus.dart';

import '../../../utils/device_info_helper.dart';

class AboutController extends GetxController {
  var appName = ''.obs;
  var packageName = ''.obs;
  var version = ''.obs;
  var buildNumber = ''.obs;
  var deviceName = ''.obs;
  var osVersion = ''.obs;
  var isLoading = true.obs;

  @override
  void onInit() {
    super.onInit();
    _loadAppInfo();
    _loadDeviceInfo();
  }

  Future<void> _loadAppInfo() async {
    final packageInfo = await PackageInfo.fromPlatform();
    appName.value = packageInfo.appName;
    packageName.value = packageInfo.packageName;
    version.value = packageInfo.version;
    buildNumber.value = packageInfo.buildNumber;
  }

  Future<void> _loadDeviceInfo() async {
    final info = await DeviceInfoHelper.getDeviceInfo();
    deviceName.value = info.$1;
    osVersion.value = info.$2;
    isLoading.value = false;
  }
}
