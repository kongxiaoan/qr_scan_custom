import Flutter
import UIKit
/*
plugin package ios 的实现部分
*/
public class SwiftQrScanCustomPlugin: NSObject, FlutterPlugin {
  public static func register(with registrar: FlutterPluginRegistrar) {
    let channel = FlutterMethodChannel(name: "qr_scan_custom", binaryMessenger: registrar.messenger())
    let instance = SwiftQrScanCustomPlugin()
    registrar.addMethodCallDelegate(instance, channel: channel)
  }

  public func handle(_ call: FlutterMethodCall, result: @escaping FlutterResult) {
    result("iOS " + UIDevice.current.systemVersion)
  }
}
