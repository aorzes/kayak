//
//  prvaScena.m
//  Kayak
//
//  Created by Anton Orzes on 30.12.2015..
//  Copyright © 2015. Anton Orzes. All rights reserved.
//

#import "prvaScena.h"

@implementation prvaScena

-(void)LoadGame{
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    aionoff = [defaults boolForKey:@"aionoff"];
    enduranceOn = [defaults boolForKey:@"enduranceOn"];
    brojKrugova = [defaults integerForKey:@"brojKrugova"];
    mapa = [defaults integerForKey:@"mapa"];
    bojaKajaka = [defaults integerForKey:@"bojaKajaka"];
    ukupnoNovaca = [defaults integerForKey:@"ukupnoNovaca"];
    if(brojKrugova == 0)
    {
        brojKrugova =3;
        aionoff = YES;
        enduranceOn = NO;
        mapa = 0;
    }
}

-(void)SaveGame {
    NSUserDefaults *defaults = [NSUserDefaults standardUserDefaults];
    [defaults setFloat:ukupnoVrijeme forKey:@"ukupnoVrijeme"];
    [defaults setInteger:novac forKey:@"novac"];
    [defaults setInteger:brojKrugova forKey:@"brojKrugova"];
    [defaults setFloat:a forKey:@"akrug"];
    ukupnoNovaca +=novac;
    [defaults setInteger:ukupnoNovaca forKey:@"ukupnoNovaca"];
    [defaults synchronize];
}


-(void)didMoveToView:(SKView *)view
{
    
    [self LoadGame];
    krug = 0;
    novac = 0;
    ukupnoVrijeme = 0;
    krugoviLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    krugoviLabel.text=[NSString stringWithFormat:@"Lap:%d",krug];
    krugoviLabel.fontSize = 20;
    krugoviLabel.position = CGPointMake(50, self.frame.size.height-70);
    krugoviLabel.zPosition=10;
    [self addChild:krugoviLabel];
    
    novciLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    novciLabel.text=[NSString stringWithFormat:@"$:%d",novac];
    novciLabel.fontSize = 20;
    novciLabel.position = CGPointMake(50, self.frame.size.height-90);
    novciLabel.zPosition=10;
    [self addChild:novciLabel];
    
    timeLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    timeLabel.text=[NSString stringWithFormat:@"Time:%.1f",ukupnoVrijeme];
    timeLabel.fontSize = 20;
    timeLabel.position = CGPointMake(self.frame.size.width-60, self.frame.size.height-90);
    timeLabel.zPosition=10;
    [self addChild:timeLabel];
    
    float umnozak=6.9;
    self.physicsWorld.gravity = CGVectorMake(0, -0.2);
    centar = [SKNode node];
    centar.position =CGPointMake(self.size.width*umnozak/2.1, self.size.height/2);
    centar.zPosition = 2;
    [self addChild:centar];
    
    
    NSURL *vesloZ = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"vesloSound3" ofType:@"wav"]];
    
    vesloSound1 = [[AVAudioPlayer alloc]initWithContentsOfURL:vesloZ error:nil];
    [vesloSound1 prepareToPlay];
    
    vesloSound2 = [[AVAudioPlayer alloc]initWithContentsOfURL:vesloZ error:nil];
    [vesloSound2 prepareToPlay];
    
    
    
    brzinaBrzaca = 4;
//izbor mape
    NSString *prvoIme = @"staza5";
    NSString *drugoIme = @"zemlja5U";
    NSString *treceIme = @"zemlja5";
    NSString *cetvrtoIme = @"voda4";
    
    NSURL *playRiver = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"bird" ofType:@"mp3"]];
    
    switch (mapa) {
        case 0:
            prvoIme = @"staza1";
            drugoIme = @"zemlja1U";
            treceIme = @"zemlja1";
            cetvrtoIme = @"voda1";
            playRiver = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"bird" ofType:@"mp3"]];
            break;
        case 1:
            prvoIme = @"staza2";
            drugoIme = @"zemlja2U";
            treceIme = @"zemlja2";
            cetvrtoIme = @"voda3";
            playRiver = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"rijeka1" ofType:@"wav"]];
            break;
        case 2:
            prvoIme = @"staza3";
            drugoIme = @"zemlja3U";
            treceIme = @"zemlja3";
            cetvrtoIme = @"voda2";
            brzinaBrzaca = 6;
            playRiver = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"rijeka2" ofType:@"wav"]];
            break;
        case 3:
            prvoIme = @"staza4";
            drugoIme = @"zemlja4U";
            treceIme = @"zemlja4";
            playRiver = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"bird" ofType:@"mp3"]];
            break;
        case 4:
            prvoIme = @"staza5";
            drugoIme = @"zemlja5U";
            treceIme = @"zemlja5";
            playRiver = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"bird" ofType:@"mp3"]];
            break;
            
        default:
            prvoIme = @"staza5";
            drugoIme = @"zemlja5U";
            treceIme = @"zemlja5";
            playRiver = [NSURL fileURLWithPath:[[NSBundle mainBundle]pathForResource:@"bird" ofType:@"mp3"]];
            break;
    }

    riverSounds = [[AVAudioPlayer alloc]initWithContentsOfURL:playRiver error:nil];
    riverSounds.volume = 0.2;
    [riverSounds setNumberOfLoops: -1];
    [riverSounds prepareToPlay];
    [riverSounds play];

    
    voda1 = [SKSpriteNode spriteNodeWithImageNamed:cetvrtoIme];
    voda1.position = CGPointMake(self.size.width/2, self.size.height/2);
    voda1.size = CGSizeMake(self.size.width, self.size.height);
    voda1.zPosition=0;
    [self addChild:voda1];

    
    //ovo je trava drvece i ostalo na obali
    myWorld = [SKSpriteNode spriteNodeWithImageNamed:prvoIme];
    myWorld.size=CGSizeMake(self.size.width*umnozak, self.size.width*umnozak);
    myWorld.position = CGPointMake(0, 0);
    myWorld.zPosition = 4;
    [centar addChild:myWorld];
    
    //unutarni i vanjski dio koji je bodi kako camac ne bi isao na obalu
    unutarnja = [SKSpriteNode spriteNodeWithImageNamed:drugoIme];
    unutarnja.size=CGSizeMake(self.size.width*umnozak, self.size.width*umnozak);
    unutarnja.position = CGPointMake(0, 0);
    unutarnja.zPosition = 1;
    unutarnja.alpha =0;
    unutarnja.physicsBody = [SKPhysicsBody bodyWithTexture:unutarnja.texture size:unutarnja.size];
    unutarnja.physicsBody.affectedByGravity = NO;
    unutarnja.physicsBody.dynamic = NO;
    [centar addChild:unutarnja];
    
    vanjska = [SKSpriteNode spriteNodeWithImageNamed:treceIme];
    vanjska.size=CGSizeMake(self.size.width*umnozak, self.size.width*umnozak);
    vanjska.position = CGPointMake(0, 0);
    vanjska.zPosition = 1;
    vanjska.alpha =0;
    vanjska.physicsBody = [SKPhysicsBody bodyWithTexture:vanjska.texture size:vanjska.size];
    vanjska.physicsBody.affectedByGravity = NO;
    vanjska.physicsBody.dynamic = NO;
    [centar addChild:vanjska];
  //kraj izbora mape
    
   
    NSArray *popisKajaka = @[@"kayakRed", @"kayakBlue", @"kayakYellow", @"kayakCyan", @"kayakGreen", @"kayakPurple", @"kayakWhite", @"kayakBlack"];
    NSString *imeKajaka = popisKajaka[bojaKajaka];
    
    kajak = [SKSpriteNode spriteNodeWithImageNamed:imeKajaka];
    kajak.position = CGPointMake(self.size.width/2-40, self.size.height/2);;
    kajak.size = CGSizeMake(20, 80);
    kajak.zPosition=4;
    kajak.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:kajak.size];
    kajak.physicsBody.linearDamping=0.9;
    kajak.physicsBody.angularDamping=0.9;
    [self addChild:kajak];
    
    veslac = [SKSpriteNode spriteNodeWithImageNamed:@"veslacRed"];
    veslac.position = CGPointMake(0, -5);;
    veslac.size = CGSizeMake(60, 20);
    veslac.zPosition=1;
    [kajak addChild:veslac];
    
    CGPoint mjesto = [myWorld convertPoint:kajak.position fromNode:self];
    startCilj = [SKSpriteNode spriteNodeWithImageNamed:@"start"];
    startCilj.size=CGSizeMake(300, 10);
    startCilj.position = mjesto;
   // startCilj.position = CGPointMake(-r+startCilj.size.width/2, self.size.height/2);
    startCilj.name = @"start";
    startCilj.zPosition = -4;
    [myWorld addChild:startCilj];
    
    
    //drugi kajak - protivnik
    if(aionoff)
    {
        NSInteger bojaKajaka2 = bojaKajaka +1;
        if (bojaKajaka2>7) {
            bojaKajaka2 =0;
        }
        NSString *imeKajaka2 = popisKajaka[bojaKajaka2];
        kajak2 = [SKSpriteNode spriteNodeWithImageNamed:imeKajaka2];
        kajak2.position = CGPointMake(self.size.width/2-65, self.size.height/2);;
        kajak2.size = CGSizeMake(20, 80);
        kajak2.zPosition=4;
        kajak2.physicsBody=[SKPhysicsBody bodyWithRectangleOfSize:kajak.size];
        kajak2.physicsBody.linearDamping=0.9;
        kajak2.physicsBody.angularDamping=0.9;
        [self addChild:kajak2];
    
        veslac2 = [SKSpriteNode spriteNodeWithImageNamed:@"veslacBlue"];
        veslac2.position = CGPointMake(0, -5);;
        veslac2.size = CGSizeMake(60, 20);
        veslac2.zPosition=1;
        [kajak2 addChild:veslac2];
    
        SKAction *lijevoRot = [SKAction rotateToAngle:0.9 duration:0.8];
        SKAction *plusniLijevo =[SKAction performSelector:@selector(buc2L) onTarget:self];
        SKAction *desnoRot = [SKAction rotateToAngle:-0.9 duration:0.8];
        SKAction *plusniDesno =[SKAction performSelector:@selector(buc2R) onTarget:self];
        SKAction *zajednoVeslaj =[SKAction repeatActionForever:[SKAction sequence:@[lijevoRot,plusniLijevo,desnoRot,plusniDesno]]];
        [veslac2 runAction:zajednoVeslaj];
    
        potezac2 = [SKShapeNode shapeNodeWithCircleOfRadius:2.5];
        potezac2.position = CGPointMake(kajak2.position.x,kajak2.position.y+kajak2.size.height/2);
        potezac2.zPosition=0;
        potezac2.alpha = 1;
        [self addChild:potezac2];
        potezac2Timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(miciCamac2) userInfo:nil repeats:YES];
        bDodatak = 0;
        rDodatak =50;
    }
    //kraj drugog kajaka
    
    pljuskanje = [NSTimer scheduledTimerWithTimeInterval:0.3 target:self selector:@selector(napraviTrag) userInfo:nil repeats:YES];
    a=0;
    b=3.14;
    dkut=0;
    impuls=0;
    
    
    r=self.size.width*umnozak/2.4;
    for (float kk=-0.02; kk<M_PI*2; kk+=M_PI/7) {
        SKSpriteNode *kamen = [SKSpriteNode spriteNodeWithImageNamed:@"kamen6"];
        kamen.position = CGPointMake(r*cos(kk), r*sin(kk));
        kamen.size = CGSizeMake(20, 20);
        kamen.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:10];
        kamen.physicsBody.affectedByGravity = NO;
        kamen.physicsBody.dynamic = NO;
        kamen.name = @"kamen";
        kamen.zPosition=-2;
        [myWorld addChild:kamen];
    }
    pljusKamena = [NSTimer scheduledTimerWithTimeInterval:1.5 target:self selector:@selector(tragKamena) userInfo:nil repeats:YES];
    
    //riba
    
    NSMutableArray *tekstureRibe = [[NSMutableArray alloc]init];
    for (int i=0; i<10; i++) {
        [tekstureRibe addObject:[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"riba%d",i]]];
    }
    SKAction *ribaAnim = [SKAction animateWithTextures:tekstureRibe timePerFrame:0.15];
    SKAction *pauzaRiba = [SKAction waitForDuration:0.5];
    SKAction *zajednoRiba =[SKAction sequence:@[ribaAnim,pauzaRiba]];
    SKAction *ponoviRiba=[SKAction repeatActionForever:zajednoRiba];
    
    riba = [SKSpriteNode spriteNodeWithImageNamed:@"riba0"];
    riba.xScale=0.5;
    riba.yScale=0.5;
    riba.position = CGPointMake(self.size.width/2, self.size.height);
    riba.name = @"riba";
    riba.zPosition=5;
    [self addChild:riba];
    riba.physicsBody = [SKPhysicsBody bodyWithCircleOfRadius:20];
    riba.physicsBody.affectedByGravity = NO;
    riba.physicsBody.allowsRotation = NO;
    [riba runAction:ponoviRiba];
    ribaTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(miciRibu) userInfo:nil repeats:YES];
    brzacTimer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(miciBrzac) userInfo:nil repeats:YES];
    [self napraviNovcice];
    [self napraviKovanice];
    for (float xx=0; xx<9;xx+=1)
    {
        [self brzac2:CGPointMake(self.size.width/3+xx*9, self.size.height+300+arc4random()%50)];
        [self brzac3:CGPointMake(self.size.width/3+xx*9+10, self.size.height+300+arc4random()%50)];
        
    }
    
    
    
}

-(void) napraviBrzac{
    
    CGPoint pb= CGPointMake(self.size.width/2, self.size.height/2);
    [self brzac:pb];
    
    
}

-(void) napraviKovanice{
    // novci Emitter
    NSString *paraPath =[[NSBundle mainBundle] pathForResource:@"MyParticle" ofType:@"sks"];
    para = [NSKeyedUnarchiver unarchiveObjectWithFile:paraPath];
    para.position=CGPointMake(0, 0);
    para.zPosition=5;
    para.name=@"novci";
    para.zRotation = 0.0;
    para.alpha=0;
    [kajak addChild:para];
    
}

-(void) napraviNovcice{
    
    //novcici sloka
    
    NSMutableArray *tekstureNovcici = [[NSMutableArray alloc]init];
    for (int i=0; i<10; i++) {
        [tekstureNovcici addObject:[SKTexture textureWithImageNamed:[NSString stringWithFormat:@"novcic%d",i]]];
    }
    SKAction *novciciAnim = [SKAction animateWithTextures:tekstureNovcici timePerFrame:0.1];
    SKAction *ponoviNovcici=[SKAction repeatActionForever:novciciAnim];
    
    novcic = [SKSpriteNode spriteNodeWithImageNamed:@"novcic0"];
    novcic.xScale=1.5;
    novcic.yScale=1.5;
    novcic.position = CGPointMake(0, 30);
    novcic.name = @"novcic";
    novcic.zPosition=9;
    novcic.alpha = 0;
    [kajak addChild:novcic];
    [novcic runAction:ponoviNovcici];
    
    
    
}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        
        
        
        if (location.x < kajak.position.x)
        {
            SKAction *lijevoRot = [SKAction rotateToAngle:0.9 duration:0.3];
            [veslac runAction:lijevoRot];
            [vesloSound1 play];
            
        }
        else
        {
            SKAction *desnoRot = [SKAction rotateToAngle:-0.9 duration:0.3];
            [veslac runAction:desnoRot];
            [vesloSound2 play];
            
        }
        
        
        
    }
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    CGPoint p = [[touches anyObject] locationInNode:self];
    CGPoint op = [[touches anyObject] previousLocationInNode:self];
    impuls=(op.y-p.y)/25;
    if(p.x<kajak.position.x) dkut=(p.y-op.y)/500;
    if(p.x>kajak.position.x) dkut=(op.y-p.y)/500;
    
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    CGPoint p = [[touches anyObject] locationInNode:self];
    if (p.x < kajak.position.x) [self buc:3.14];else [self buc:0];
    
    SKAction *vratiRot = [SKAction rotateToAngle:0.0 duration:0.5];
    [veslac runAction:vratiRot];
}

-(void) buc:(float)ld{
    
    SKNode *veslo = [SKNode node];
    veslo.position = CGPointMake(kajak.position.x+cos(kajak.zRotation+ld)*27, kajak.position.y-15+sin(kajak.zRotation+ld)*27);
    [self addChild: veslo];
    
    CGPoint mjesto = [myWorld convertPoint:[self position] fromNode:veslo];
    SKSpriteNode *pljus = [SKSpriteNode spriteNodeWithImageNamed:@"pljus"];
    pljus.xScale = 0.1;
    pljus.yScale = 0.1;
    pljus.position = mjesto;
    pljus.zPosition=-1;
    SKAction *nestani = [SKAction fadeOutWithDuration:1.0];
    SKAction *povecaj = [SKAction scaleTo:0.8 duration:1.1];
    SKAction *zajedno = [SKAction group:@[nestani,povecaj]];
    SKAction *removeNode = [SKAction removeFromParent];
    SKAction *zadrugim = [SKAction sequence:@[zajedno,removeNode]];
    [pljus runAction:zadrugim];
    [myWorld addChild:pljus];
    [veslo removeFromParent];
    
}

-(void) buc2L {
    
    SKNode *veslo = [SKNode node];
    veslo.position = CGPointMake(kajak2.position.x+cos(kajak2.zRotation+3.14)*27, kajak2.position.y-15+sin(kajak2.zRotation+3.14)*27);
    [self addChild: veslo];
    CGPoint mjesto = [myWorld convertPoint:[self position] fromNode:veslo];
    SKSpriteNode *pljus = [SKSpriteNode spriteNodeWithImageNamed:@"pljus"];
    pljus.xScale = 0.1;
    pljus.yScale = 0.1;
    pljus.position = mjesto;
    pljus.zPosition=-1;
    SKAction *nestani = [SKAction fadeOutWithDuration:1.0];
    SKAction *povecaj = [SKAction scaleTo:0.8 duration:1.1];
    SKAction *zajedno = [SKAction group:@[nestani,povecaj]];
    SKAction *removeNode = [SKAction removeFromParent];
    SKAction *zadrugim = [SKAction sequence:@[zajedno,removeNode]];
    [pljus runAction:zadrugim];
    [myWorld addChild:pljus];
    [veslo removeFromParent];
    
}

-(void) buc2R {
    
    SKNode *veslo = [SKNode node];
    veslo.position = CGPointMake(kajak2.position.x+cos(kajak2.zRotation)*27, kajak2.position.y-15+sin(kajak2.zRotation)*27);
    [self addChild: veslo];
    CGPoint mjesto = [myWorld convertPoint:[self position] fromNode:veslo];
    SKSpriteNode *pljus = [SKSpriteNode spriteNodeWithImageNamed:@"pljus"];
    pljus.xScale = 0.1;
    pljus.yScale = 0.1;
    pljus.position = mjesto;
    pljus.zPosition=-1;
    SKAction *nestani = [SKAction fadeOutWithDuration:1.0];
    SKAction *povecaj = [SKAction scaleTo:0.8 duration:1.1];
    SKAction *zajedno = [SKAction group:@[nestani,povecaj]];
    SKAction *removeNode = [SKAction removeFromParent];
    SKAction *zadrugim = [SKAction sequence:@[zajedno,removeNode]];
    [pljus runAction:zadrugim];
    [myWorld addChild:pljus];
    [veslo removeFromParent];
    
}


-(void) napraviTrag{
    
    SKNode *rep = [SKNode node];
    rep.position = CGPointMake(kajak.position.x, kajak.position.y+kajak.size.height/2-5);
    [self addChild: rep];
    CGPoint mjesto = [myWorld convertPoint:[self position] fromNode:kajak];
    SKSpriteNode *pljus = [SKSpriteNode spriteNodeWithImageNamed:@"pljus"];
    pljus.xScale = 0.1;
    pljus.yScale = 0.1;
    pljus.position = mjesto;
    pljus.zPosition=-3;
    SKAction *nestani = [SKAction fadeOutWithDuration:2.5];
    SKAction *povecaj = [SKAction scaleTo:0.9 duration:2.5];
    SKAction *zajedno = [SKAction group:@[nestani,povecaj]];
    SKAction *removeNode = [SKAction removeFromParent];
    SKAction *zadrugim = [SKAction sequence:@[zajedno,removeNode]];
    [pljus runAction:zadrugim];
    [myWorld addChild:pljus];
    [rep removeFromParent];
    if(aionoff){[self napraviTrag2];}
}

-(void) napraviTrag2{
    
    SKNode *rep = [SKNode node];
    rep.position = CGPointMake(kajak2.position.x, kajak2.position.y+kajak2.size.height/2-5);
    [self addChild: rep];
    CGPoint mjesto = [myWorld convertPoint:[self position] fromNode:kajak2];
    SKSpriteNode *pljus = [SKSpriteNode spriteNodeWithImageNamed:@"pljus"];
    pljus.xScale = 0.1;
    pljus.yScale = 0.1;
    pljus.position = mjesto;
    pljus.zPosition=-3;
    SKAction *nestani = [SKAction fadeOutWithDuration:2.5];
    SKAction *povecaj = [SKAction scaleTo:0.9 duration:2.5];
    SKAction *zajedno = [SKAction group:@[nestani,povecaj]];
    SKAction *removeNode = [SKAction removeFromParent];
    SKAction *zadrugim = [SKAction sequence:@[zajedno,removeNode]];
    [pljus runAction:zadrugim];
    [myWorld addChild:pljus];
    [rep removeFromParent];
    
}


-(void) pljusKamena:(CGPoint)polozajKamena{
    
    SKSpriteNode *pljus = [SKSpriteNode spriteNodeWithImageNamed:@"pljus"];
    pljus.xScale = 0.3;
    pljus.yScale = 0.3;
    pljus.position = polozajKamena;
    pljus.zPosition=-4;
    SKAction *nestani = [SKAction fadeOutWithDuration:2.5];
    SKAction *povecaj = [SKAction scaleTo:1.5 duration:2.5];
    SKAction *zajedno = [SKAction group:@[nestani,povecaj]];
    SKAction *removeNode = [SKAction removeFromParent];
    SKAction *zadrugim = [SKAction sequence:@[zajedno,removeNode]];
    [pljus runAction:zadrugim];
    [myWorld addChild:pljus];
    
    
}

-(void) brzac:(CGPoint)polozaj{
    
    for(float p=0.2;p<2.0; p+=0.2)
    {
        SKSpriteNode *pljus = [SKSpriteNode spriteNodeWithImageNamed:@"pljus"];
        pljus.xScale = p;
        pljus.yScale = p;
        pljus.position = CGPointMake(polozaj.x, polozaj.y - p*100);
        pljus.zPosition=4;
        SKAction *nestani = [SKAction fadeOutWithDuration:2.5];
        SKAction *povecaj = [SKAction scaleTo:p*3 duration:2.5];
        SKAction *zajedno = [SKAction group:@[nestani,povecaj]];
        SKAction *removeNode = [SKAction removeFromParent];
        SKAction *zadrugim = [SKAction sequence:@[zajedno,removeNode]];
        [pljus runAction:zadrugim];
        [self addChild:pljus];
    }
    
    
}

-(void) brzac2:(CGPoint)polozaj{
    
    SKSpriteNode *pljus = [SKSpriteNode spriteNodeWithImageNamed:@"brzac0"];
    pljus.xScale = 0.3;
    pljus.yScale = 0.7;
    pljus.name = @"brzac";
    pljus.position = polozaj;
    pljus.zPosition=4;
    pljus.alpha = 0.1;
    [self addChild:pljus];
    NSArray *namePljus = @[@"brzac0",@"brzac2",@"brzac4",@"brzac6",@"brzac8",@"brzac10"];
    
    NSMutableArray *teksturePljus=[[NSMutableArray alloc]init];
    int n = arc4random() % namePljus.count;
    for (int i=0; i<namePljus.count; i++) {
        
        [teksturePljus addObject:[SKTexture textureWithImageNamed:namePljus[n]]];
        n++;
        if(n>=namePljus.count) n=0;
    }
    SKAction *brzacAnim = [SKAction animateWithTextures:teksturePljus timePerFrame:0.1];
    SKAction *ponoviBrzac=[SKAction repeatActionForever:brzacAnim];
    [pljus runAction:ponoviBrzac];
    
    
}
-(void) brzac3:(CGPoint)polozaj{
    
    SKSpriteNode *pljus = [SKSpriteNode spriteNodeWithImageNamed:@"brzac0"];
    pljus.xScale = 0.3;
    pljus.yScale = 0.7;
    pljus.name = @"brzac";
    pljus.position = polozaj;
    pljus.zPosition=4;
    pljus.alpha = 0.1;
    [self addChild:pljus];
    NSArray *namePljus = @[@"brzac1",@"brzac3",@"brzac5",@"brzac7",@"brzac9"];
    NSMutableArray *teksturePljus=[[NSMutableArray alloc]init];
    int n = arc4random() % namePljus.count;
    for (int i=0; i<namePljus.count; i++) {
        
        [teksturePljus addObject:[SKTexture textureWithImageNamed:namePljus[n]]];
        n++;
        if(n>=namePljus.count) n=0;
    }
    
    SKAction *brzacAnim = [SKAction animateWithTextures:teksturePljus timePerFrame:0.1];
    SKAction *ponoviBrzac=[SKAction repeatActionForever:brzacAnim];
    [pljus runAction:ponoviBrzac];
    
    
}



-(void) tragKamena{
    for(SKSpriteNode *nod in myWorld.children){
        CGPoint mjesto = [self convertPoint:[myWorld position] fromNode:nod];
        if([nod.name isEqualToString:@"kamen"] && [voda1 containsPoint:mjesto]){
            
            [self pljusKamena:nod.position];
            
        }
        krug=(int)(a/(2*M_PI));
        krugoviLabel.text=[NSString stringWithFormat:@"Lap:%d",krug+1];
    }
    
    
}



-(void) miciCamac{
    kut+=dkut;
    if (dkut>0) {dkut-=0.0001;}else if(dkut<0){dkut+=0.0001;}
    kajak.zRotation=kut;
    if(kajak.position.y<self.size.height-80)
    {
        [kajak.physicsBody applyImpulse:CGVectorMake(impuls*sin(-kut),impuls*cos(kut))];
        
    }
    else
    {
        a+=0.0015;
    }
    impuls=0;
    [kajak.physicsBody applyImpulse:CGVectorMake(0,-0.02*cos(kut))];
    
    
}

-(void) miciCamac2{
    
   
    if (kajak2.position.y>kajak.position.y) {
        b-=0.00030;
    }
    else
    {
        b-=0.00040;
    }
    bDodatak += 0.2;
    rDodatak= sin(bDodatak)*30+40;
    potezac2.position = CGPointMake(centar.position.x + (r + rDodatak) * cos(b) , centar.position.y + (r + rDodatak) * sin(b));
    float kt = atan2f(kajak2.position.y-potezac2.position.y, kajak2.position.x-potezac2.position.x)+M_PI_2;
    kajak2.zRotation = kt;
    CGFloat distance = hypotf(kajak2.position.x - potezac2.position.x, kajak2.position.y - potezac2.position.y);
    if (distance>80) {
        [kajak2.physicsBody applyImpulse:CGVectorMake(cos(kt+M_PI_2), sin(kt+M_PI_2))];
        if (kajak2.position.y<-50) {
            CGPoint pkk= kajak2.position;
            pkk.x =self.size.width/2;
            pkk.y =0;
            kajak2.position=pkk;
            b=3.14;
        }
    }
    
    
    
}


-(void) miciRibu{
    ukupnoVrijeme+=0.1;
    timeLabel.text=[NSString stringWithFormat:@"%.1f''",ukupnoVrijeme];
    CGPoint pr=riba.position;
    pr.y-=1;
    if(pr.y<-20) pr.y= self.size.height + 20;
    riba.position = pr;
    if([kajak intersectsNode:riba]){
        novac+=10;
        novciLabel.text=[NSString stringWithFormat:@"$:%d",novac];
        riba.position = CGPointMake(self.size.height/2, self.size.height+20);
        para.alpha = 1;
        novcic.alpha=1;
        SKAction *cekajParu = [SKAction waitForDuration:2];
        SKAction *ugasiParu = [SKAction fadeOutWithDuration:0.5];
        SKAction *zajednoPara = [SKAction sequence:@[cekajParu,ugasiParu]];
        [para runAction:zajednoPara];
        [novcic runAction:zajednoPara];
        
    }
    
}

-(void) miciBrzac{
    
    for(SKSpriteNode *nod in self.children){
        if ([nod.name isEqualToString:@"brzac"] ) {
            CGPoint pr=nod.position;
            pr.y-=brzinaBrzaca;
            if(pr.y<-100) pr.y= self.size.height + 200;
            nod.position = pr;
            if([kajak intersectsNode:nod])
            {
                self.physicsWorld.gravity = CGVectorMake(0, -1.5);
            }
            else
            {
                self.physicsWorld.gravity = CGVectorMake(0, -0.2);
            }
            
        }
    }
}
-(void) PraznaFunkcija{

    NSLog(@"prazno");

}

-(void)mici_kameru{
    
    a+=0.001;
    centar.zRotation = a;
    if(kajak.position.y<-40)
    {
        //gubitak
        [pljuskanje invalidate];
        [pljusKamena invalidate];
        [ribaTimer invalidate];
        [brzacTimer invalidate];
        [potezac2Timer invalidate];
        [riverSounds stop];
        [self SaveGame];
        SKScene *igra = [[fallScene alloc]initWithSize:self.size];
        igra.scaleMode = SKSceneScaleModeAspectFill;
        SKTransition *tranzicija = [SKTransition pushWithDirection:SKTransitionDirectionDown duration:0.4];
        [self.view presentScene:igra transition:tranzicija];
        
    }
    //if ([kajak intersectsNode:startCilj]) NSLog(@"dodir %.2f",(a/(2*M_PI*brojKrugova)));
    
    if([kajak intersectsNode:startCilj] && (a/(2*M_PI*brojKrugova))>0.9 && !enduranceOn){
        //pobjeda win game
       
        [self SaveGame];
        [pljuskanje invalidate];
        pljuskanje = nil;
        [pljusKamena invalidate];
        pljusKamena =nil;
        [ribaTimer invalidate];
        ribaTimer = nil;
        [brzacTimer invalidate];
        brzacTimer = nil;
        [potezac2Timer invalidate];
        potezac2Timer = nil;
        [riverSounds stop];
        riverSounds = nil;
        
        SKScene *igra = [[winScene alloc]initWithSize:self.size];
        SKTransition *tranzicija = [SKTransition pushWithDirection:SKTransitionDirectionDown duration:1.4];
        [self.view presentScene:igra transition:tranzicija];
        
        
        
    }


    
}



-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
    
   
        [self mici_kameru];
        [self miciCamac];
    
    
    
}


@end
