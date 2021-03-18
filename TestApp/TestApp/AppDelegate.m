//
//  AppDelegate.m
//  TestApp
//
//  Created by Andrey on 08/03/2021.
//

#import "AppDelegate.h"
#import "ViewController.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    CGRect frame = [[UIScreen mainScreen] bounds];
    self.window = [[UIWindow alloc] initWithFrame:  frame];
    
    ViewController *viewController = [ViewController new];
    
    UINavigationController  *navigationController = [[UINavigationController alloc] initWithRootViewController: viewController];
    [self.window setRootViewController:navigationController];
    [self.window makeKeyAndVisible];
    
    return YES;
}





@end
