//
//  GameScene.h
//  Kayak
//

//  Copyright (c) 2015. Anton Orzes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <GameplayKit/GameplayKit.h>
#import "prvaScena.h"
#import "izbornikScene.h"
#import "izbornikKajaka.h"
#import "gameCenterFiles.h"


@interface GameScene : SKScene<GKGameCenterControllerDelegate>

{
    SKShapeNode *osovina;
    SKSpriteNode *aiOnOff;
    SKSpriteNode *endurance;
    SKSpriteNode *poluga;
    NSInteger brojKrugova;
    NSInteger  mapa;
    BOOL aionoff,enduranceOn;
    UIActivityIndicatorView *spinner;
    AVAudioPlayer *plopSounds;

}

@end
