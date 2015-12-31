//
//  prvaScena.h
//  Kayak
//
//  Created by Anton Orzes on 30.12.2015..
//  Copyright © 2015. Anton Orzes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>

@interface prvaScena : SKScene

{
    SKLabelNode *krugoviLabel;
    SKLabelNode *novciLabel;
    
    SKNode *centar;
    SKSpriteNode *myWorld;
    SKSpriteNode *voda1;
    SKSpriteNode *riba;
    SKSpriteNode *novcic;
    float a,b,bDodatak,r,rDodatak;
    int krug;
    int novac;
    NSTimer *pljuskanje;
    NSTimer *pljusKamena;
    NSTimer *ribaTimer;
    NSTimer *brzacTimer;
    NSTimer *potezac2Timer;
    SKSpriteNode *kajak;
    SKSpriteNode *veslac;
    
    SKSpriteNode *kajak2;
    SKSpriteNode *veslac2;
    SKShapeNode *potezac2;
    
    double impuls, dkut, kut;
    AVAudioPlayer *riverSounds;
    SKEmitterNode * para;
}


@end
