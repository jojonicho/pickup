#include "AppDelegate.h"
#include "GeneratedPluginRegistrant.h"
#import "GoogleMaps/GoogleMaps.h"

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application
    didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // NSString* mapsApiKey = [[NSProcessInfo processInfo] environment][@"FLUTTER_GMAPS_API_KEY"];
  [GMSServices provideAPIKey: @"AIzaSyDGjxpaJ94lMuq5barovW2O6-mF1cpC3yg"];
  [GeneratedPluginRegistrant registerWithRegistry:self];
  return [super application:application didFinishLaunchingWithOptions:launchOptions];
}

@end
