#import "OkraWidgetPlugin.h"
#if __has_include(<okra_widget/okra_widget-Swift.h>)
#import <okra_widget/okra_widget-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "okra_widget-Swift.h"
#endif

@implementation OkraWidgetPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftOkraWidgetPlugin registerWithRegistrar:registrar];
}
@end
