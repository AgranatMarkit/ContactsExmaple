//
//  AppDelegate.m
//  Test
//
//  Created by Марк on 05.04.2018.
//  Copyright © 2018 Agranat Mark. All rights reserved.
//

#import "AppDelegate.h"
#import "ContactsModuleAssembler.h"

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [self setupViewController];
    return YES;
}

- (void)setupViewController {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    ContactsViewController *contactsVC = [ContactsModuleAssembler assemble];
    UINavigationController *nc = [[UINavigationController alloc] initWithRootViewController:contactsVC];
    [nc.view setBackgroundColor:UIColor.whiteColor];
    self.window.rootViewController = nc;
    [self.window makeKeyAndVisible];
}

@end
