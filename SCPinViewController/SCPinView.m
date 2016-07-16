//
//  SCPinView.m
//  SCPinViewController
//
//  Created by Maxim Kolesnik on 16.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import "SCPinView.h"

@implementation SCPinView
-(instancetype)init {
    self = [super init];
    if (self) {
        [self applyDefautlAttributes];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self applyDefautlAttributes];
    }
    return self;
}

-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        [self applyDefautlAttributes];
    }
    return self;
}

-(void)applyDefautlAttributes {
    self.backgroundColor = [UIColor clearColor];
    self.fillColor = [UIColor redColor];
    self.strokeColor = [UIColor blueColor];
    self.strokeWidth = 0.5f;
    self.highlighted = YES;
    self.highlightedColor  = [UIColor greenColor];
}

- (void)drawRect:(CGRect)rect {
    
    CGRect bezierPathRect = CGRectMake(self.strokeWidth, self.strokeWidth, CGRectGetWidth(rect) - (self.strokeWidth * 2), CGRectGetHeight(rect) - (self.strokeWidth * 2));
    UIBezierPath* ovalPath = [UIBezierPath bezierPathWithOvalInRect: bezierPathRect];
    if (self.highlighted) {
        [self.highlightedColor setFill];
    } else {
        [self.fillColor setFill];
    }
    [ovalPath fill];
    [self.strokeColor setStroke];
    ovalPath.lineWidth = self.strokeWidth;
    [ovalPath stroke];
}


@end
