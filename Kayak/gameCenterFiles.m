//
//  gameCenterFiles.m
//  HighChicken
//
//  Created by Anton Orzes on /15 12/15.
//  Copyright © 2015 Anton Orzes. All rights reserved.
//

#import "gameCenterFiles.h"
#import "GameScene.h"

@interface gameCenterFiles () <GKGameCenterControllerDelegate>{


    BOOL _gameCenterFeaturesEnabled;



}

@end





@implementation gameCenterFiles

@synthesize gameCEnterAvailable;
static gameCenterFiles *sharedControl = nil;

+(gameCenterFiles *)sharedInstance {

    if (!sharedControl) {
        sharedControl = [[gameCenterFiles alloc]init];
    }

    return sharedControl;
}

-(BOOL)isGameCenterAvailable {
    
    
    Class gcClass = (NSClassFromString(@"GKLocalPlayer"));
    
    NSString *reqSysVer = @"4.1";
    NSString *currSysVer = [[UIDevice currentDevice]systemVersion];
    BOOL osVersionSupported = ([currSysVer compare:reqSysVer options:NSNumericSearch]);
    
    return (gcClass && osVersionSupported);
    
}
-(id)init {
    
    
    if ((self = [super init])) {
        
        gameCenterAvailable = [self isGameCenterAvailable];
        if (gameCenterAvailable) {
            NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
            [nc addObserver:self selector:@selector(authenticationChanged) name:GKPlayerAuthenticationDidChangeNotificationName object:nil];
        }
        
        
        
    }
    
    
    return self;
    
    
    
}
-(void)authenticationChanged {
    
    
    if ([GKLocalPlayer localPlayer].isAuthenticated && !userAuthenticated) {
        
        NSLog(@"Authentication Changed. UserAuthenticated");
        userAuthenticated = TRUE;
    }
    else if (![GKLocalPlayer localPlayer].isAuthenticated && userAuthenticated) {
        
        
        NSLog(@"Authentication Changed. User Not Authenticated");
        userAuthenticated = FALSE;
        
        
    }
    
    
    
}
-(void)authenticateLocalUser {
    
    if ([GKLocalPlayer localPlayer].authenticated == NO) {
        GKLocalPlayer* localPlayer = [GKLocalPlayer localPlayer];
        
        localPlayer.authenticateHandler = ^(UIViewController *gcvc,NSError *error){
            
            
            if (gcvc) {
                [self presentViewController:gcvc];
            }
            
            else {
                _gameCenterFeaturesEnabled = NO;
                
            }
        };
        
    }
    
    else if ([GKLocalPlayer localPlayer].authenticated == YES){
        
        
        _gameCenterFeaturesEnabled = YES;
        
        
    }
}
-(UIViewController*) getRootViewController {
    
    
    return [UIApplication sharedApplication].keyWindow.rootViewController;
    
}
-(void)presentViewController:(UIViewController*)gcvc {
    
    UIViewController *rootVC = [self getRootViewController];
    [rootVC presentViewController:gcvc animated:YES completion:nil];
    
}

-(void)gameCenterViewControllerDidFinish:(GKGameCenterViewController *)gameCenterViewController {
    
    
    
    
}



@end
