package com.qrscancustom

import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel
import io.flutter.plugin.common.MethodChannel.MethodCallHandler
import io.flutter.plugin.common.MethodChannel.Result
import io.flutter.plugin.common.PluginRegistry.Registrar

/*
 * plugin package 中Android端的代码 是配合dart api 进行配合开发的
 */
class QrScanCustomPlugin : MethodCallHandler {
    companion object {
        @JvmStatic
        fun registerWith(registrar: Registrar) {
            val channel = MethodChannel(registrar.messenger(), "qr_scan_custom")
            channel.setMethodCallHandler(QrScanCustomPlugin())
        }
    }

    override fun onMethodCall(call: MethodCall, result: Result) {
        if (call.method == "useQRCodeScanning") {
            result.success("qr_code_custom")
        } else {
            result.notImplemented()
        }
    }
}
