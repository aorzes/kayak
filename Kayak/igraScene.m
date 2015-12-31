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
    [self napraviTravu];
    [self napraviKamenje];
    
    [self startA];
}

-(void) napraviTravu{

    trava1 = [SKSpriteNode spriteNodeWithImageNamed:@"travaLjeto@2x"];
    trava1.size = CGSizeMake(self.size.width, self.size.height*1.2);
    trava1.position = CGPointMake(self.size.width/2, self.size.height/2);
    trava1.name = @"trava1";
    trava1.zPosition=1;
    [self addChild:trava1];
    
    trava2 = [SKSpriteNode spriteNodeWithImageNamed:@"travaLjeto@2x"];
    trava2.size = CGSizeMake(self.size.width, self.size.height*1.2);
    trava2.position = CGPointMake(self.size.width/2, 3*self.size.height/2);
    trava2.name = @"trava2";
    trava2.zPosition=1;
    [self addChild:trava2];



}

-(void)napraviKamenje{

   NSMutableArray *kamenIme = [[NSMutableArray alloc] init];
    NSString *ime;
    for(int i=1;i<7;i++)
    {
        ime = [NSString stringWithFormat:@"kamen%d",i];
        [kamenIme addObject:ime];
    
    }
    CGFloat brKamenja=40;
    velKamena = self.size.height/(brKamenja+1);
    int n=0;
    //CGFloat pozKamena = self.size.height+velKamena/2;
    CGFloat pozKamena = -velKamena/2;
    for(int i=0; i<brKamenja+3; i++)
    {
        SKSpriteNode *kamen = [SKSpriteNode spriteNodeWithImageNamed:kamenIme[n]];
        CGFloat pluSize = arc4random() % 10;
        kamen.size = CGSizeMake(velKamena+pluSize, velKamena+pluSize);
        CGFloat lijevo = sin(a) * 40;
        kamen.position = CGPointMake(self.size.width/4+lijevo, pozKamena);
        kamen.zRotation = (arc4random() % 60)/10;
        kamen.name = @"kamen1";
        kamen.zPosition=3;
        [self addChild:kamen];
        
        SKSpriteNode *kamen2 = [SKSpriteNode spriteNodeWithImageNamed:kamenIme[n]];
        kamen2.size = CGSizeMake(velKamena+pluSize, velKamena+pluSize);
        //CGFloat desno = self.size.width/2 + kamen.position.x;
        CGFloat desno = 3*self.size.width/4 + lijevo;
        kamen2.position = CGPointMake(desno, pozKamena);
        kamen2.zRotation = (arc4random() % 60)/10;
        kamen2.name = @"kamen2";
        kamen2.zPosition=3;
        [self addChild:kamen2];
        a+=0.2;
        pozKamena+=velKamena;
        n++;
        if(n>kamenIme.count-1) {n=0;}
        SKSpriteNode *voda = [SKSpriteNode spriteNodeWithImageNamed:@"voda"];
        voda.size = CGSizeMake(kamen2.position.x-kamen.position.x, velKamena+2);
        voda.position = CGPointMake((kamen.position.x+kamen2.position.x)/2, kamen.position.y);
        voda.name = @"voda";
        voda.zPosition=2;
        [self addChild:voda];
        
    
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

    for(SKNode *nod in self.children)
    {
        if ([nod.name isEqualToString:@"kamen1"] || [nod.name isEqualToString:@"kamen2"] || [nod.name isEqualToString:@"voda"] ) {
            CGPoint p = nod.position;
            p.y -= 1.0;
            if (p.y < -velKamena) {
                p.y=self.size.height+velKamena;
                
                if ([nod.name isEqualToString:@"kamen1"])
                {
                    a+=0.2;
                    p.x = self.size.width/4+sin(a)*40;
                }
                if ([nod.name isEqualToString:@"kamen2"])
                {
                    p.x = 3*self.size.width/4+sin(a)*40;
                }
                if ([nod.name isEqualToString:@"voda"])
                {
                    p.x = self.size.width/2+sin(a)*40;
                }
            }
            nod.position = p;
        }
    }
    CGPoint p1 = trava1.position;
    p1.y -= 1.0;
    trava1.self.position = p1;
    CGPoint p2 = trava2.position;
    p2.y -= 1.0;
    trava2.self.position = p2;
    if(trava1.position.y<-self.size.height/2){
        trava1.position = CGPointMake(self.size.width/2, 3*self.size.height/2);
    }
    if(trava2.position.y<-self.size.height/2){
        trava2.position = CGPointMake(self.size.width/2, 3*self.size.height/2);
    }

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
