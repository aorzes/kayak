//
//  GameScene.h
//  Kayak
//

//  Copyright (c) 2015. Anton Orzes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import "prvaScena.h"
#import "izbornikScene.h"

@interface GameScene : SKScene

{
    SKShapeNode *osovina;
    SKSpriteNode *aiOnOff;
    SKSpriteNode *endurance;
    NSInteger brojKrugova;
    BOOL aionoff,enduranceOn;
    UIActivityIndicatorView *spinner;

}
;
@end
