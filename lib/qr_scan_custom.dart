import 'dart:async';

import 'package:flutter/services.dart';

/*
 * plugin package 中dart API的部分 使用者在自己的flutter项目中的接口代码
 */
class QrScanCustom {
  static const MethodChannel _channel = const MethodChannel('qr_scan_custom');

  static Future<String> get useQRCodeScanning async {
    final String version = await _channel.invokeMethod('useQRCodeScanning');
    return version;
  }
}
