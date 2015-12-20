//
//  igraScene.m
//  Kayak
//
//  Created by Anton Orzes on 20.12.2015..
//  Copyright (c) 2015. Anton Orzes. All rights reserved.
//

#import "igraScene.h"

@implementation igraScene

-(void)didMoveToView:(SKView *)view {
    /* Setup your scene here */
    SKLabelNode *myLabel = [SKLabelNode labelNodeWithFontNamed:@"Chalkduster"];
    myLabel.text = @"Hello, World!";
    myLabel.fontSize = 35;
    myLabel.position = CGPointMake(CGRectGetMidX(self.frame),self.frame.size.height -100);
    a=0;
    [self addChild:myLabel];
    [self napraviKamenje];
    [self startA];
}

-(void)napraviKamenje{

   NSMutableArray *kamenIme = [[NSMutableArray alloc] init];
    NSString *ime;
    for(int i=1;i<6;i++)
    {
        ime = [NSString stringWithFormat:@"kamen%d",i];
        [kamenIme addObject:ime];
    
    }
    CGFloat brKamenja=40;
    CGFloat velKamena = self.size.height/brKamenja;
    int n=0;
    CGFloat pozKamena = self.size.height;
    for(int i=0; i<=brKamenja; i++)
    {
        SKSpriteNode *kamen = [SKSpriteNode spriteNodeWithImageNamed:kamenIme[n]];
        kamen.size = CGSizeMake(velKamena+5, velKamena+5);
        CGFloat lijevo = sin(a) * 40;
        kamen.position = CGPointMake(self.size.width/3+lijevo, pozKamena);
        kamen.zRotation = (arc4random() % 60)/10;
        kamen.name = @"kamen";
        kamen.zPosition=3;
        [self addChild:kamen];
        
        SKSpriteNode *kamen2 = [SKSpriteNode spriteNodeWithImageNamed:kamenIme[n]];
        kamen2.size = CGSizeMake(velKamena+5, velKamena+5);
        CGFloat desno = self.size.width/2 + kamen.position.x;
        kamen2.position = CGPointMake(desno, pozKamena);
        kamen2.zRotation = (arc4random() % 60)/10;
        kamen2.name = @"kamen";
        kamen2.zPosition=3;
        [self addChild:kamen2];
        a+=0.2;
        pozKamena-=velKamena;
        n++;
        if(n>kamenIme.count-1) {n=0;}
    
    }
    

}

-(void)startA{
    
    if(!timerA)
    { timerA = [NSTimer scheduledTimerWithTimeInterval:0.1
                                                target:self
                                              selector:@selector(pomiciVodu)
                                              userInfo:nil
                                               repeats:YES];
    }
}

-(void) pomiciVodu{



}

-(void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    /* Called when a touch begins */
    
    for (UITouch *touch in touches) {
        CGPoint location = [touch locationInNode:self];
        
        
    }
}

-(void)update:(CFTimeInterval)currentTime {
    /* Called before each frame is rendered */
}

@end
