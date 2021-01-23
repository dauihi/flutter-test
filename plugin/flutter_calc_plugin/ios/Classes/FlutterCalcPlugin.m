#import "FlutterCalcPlugin.h"
#if __has_include(<flutter_calc_plugin/flutter_calc_plugin-Swift.h>)
#import <flutter_calc_plugin/flutter_calc_plugin-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "flutter_calc_plugin-Swift.h"
#endif

@implementation FlutterCalcPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftFlutterCalcPlugin registerWithRegistrar:registrar];
}
@end
