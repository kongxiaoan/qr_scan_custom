#import "QrScanCustomPlugin.h"
#import <qr_scan_custom/qr_scan_custom-Swift.h>

@implementation QrScanCustomPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftQrScanCustomPlugin registerWithRegistrar:registrar];
}
@end
