//
//  gameCenterFiles.h
//  HighChicken
//
//  Created by Anton Orzes on /15 12/15.
//  Copyright © 2015 Anton Orzes. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <GameKit/GameKit.h>
@interface gameCenterFiles : NSObject {

    BOOL gameCenterAvailable;
    BOOL userAuthenticated;

}

@property (assign, readonly) BOOL gameCEnterAvailable;
+(gameCenterFiles *) sharedInstance;
-(void)authenticateLocalUser;

@end
