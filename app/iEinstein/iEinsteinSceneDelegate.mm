#import "iEinsteinSceneDelegate.h"
#import "iEinsteinViewController.h"

@implementation iEinsteinSceneDelegate

- (iEinsteinViewController*)viewController
{
    return (iEinsteinViewController*)self.window.rootViewController;
}

- (void)sceneWillResignActive:(UIScene*)scene
{
    [[self viewController] stopEmulator];
}

- (void)sceneDidBecomeActive:(UIScene*)scene
{
    iEinsteinViewController* viewController = [self viewController];

    if (![viewController allResourcesFound])
        return;

    NSUserDefaults* prefs = [NSUserDefaults standardUserDefaults];
    bool clearFlash = [(NSNumber*)[prefs objectForKey:@"clear_flash_ram"] boolValue];
    if (clearFlash) {
        // User requested to clear the Flash Memory.
        [prefs setValue:[NSNumber numberWithBool:NO] forKey:@"clear_flash_ram"];
        [prefs synchronize];
        [viewController stopEmulator];
        [viewController verifyDeleteFlashRAM:1];
    } else {
        [viewController startEmulator];
    }
    [viewController installNewPackages];
}

@end
