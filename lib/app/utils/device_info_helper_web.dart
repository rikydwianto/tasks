import 'dart:html' as html;

(String, String) getWebDeviceInfo() {
  final device = html.window.navigator.appName ?? 'Web Browser';
  final os = html.window.navigator.userAgent ?? 'Unknown OS';
  return (device, os);
}
