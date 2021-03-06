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
    SKLabelNode *timeLabel;
        
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
    float brzinaBrzaca;
    int krug;
    NSInteger ukupnoNovaca;
    int novac;
    NSTimer *pljuskanje;
    NSTimer *pljusKamena;
    NSTimer *ribaTimer;
    NSTimer *brzacTimer;
    NSTimer *potezac2Timer;
   
    double ukupnoVrijeme;
    NSInteger bojaKajaka;
    
    double impuls, dkut, kut;
    AVAudioPlayer *riverSounds;
    AVAudioPlayer *vesloSound1;
    AVAudioPlayer *vesloSound2;
    
    
    SKEmitterNode * para;
    
    NSInteger  brojKrugova;
    NSInteger  mapa;
    bool aionoff;
    bool enduranceOn;
    
    SKSpriteNode *startCilj;
}


@end
