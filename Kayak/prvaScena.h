//
//  prvaScena.h
//  Kayak
//
//  Created by Anton Orzes on 30.12.2015..
//  Copyright © 2015. Anton Orzes. All rights reserved.
//

#import <SpriteKit/SpriteKit.h>
#import <AVFoundation/AVFoundation.h>
#import "fallScene.h"
#import "winScene.h"

@interface prvaScena : SKScene

{
    SKLabelNode *krugoviLabel;
    SKLabelNode *novciLabel;
    
    SKNode *centar;
    SKSpriteNode *myWorld;
    SKSpriteNode *unutarnja;
    SKSpriteNode *vanjska;
    SKSpriteNode *voda1;
    SKSpriteNode *riba;
    SKSpriteNode *novcic;
    SKSpriteNode *kajak;
    SKSpriteNode *veslac;
    
    SKSpriteNode *kajak2;
    SKSpriteNode *veslac2;
    SKShapeNode *potezac2;
    
    float a,b,bDodatak,r,rDodatak;
    int krug;
    int novac;
    NSTimer *pljuskanje;
    NSTimer *pljusKamena;
    NSTimer *ribaTimer;
    NSTimer *brzacTimer;
    NSTimer *potezac2Timer;
   
    double ukupnoVrijeme;
    
    double impuls, dkut, kut;
    AVAudioPlayer *riverSounds;
    SKEmitterNode * para;
    
    NSInteger  brojKrugova;
    NSInteger  mapa;
    bool aionoff;
    bool enduranceOn;
}


@end
