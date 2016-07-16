//
//  SCPinView.h
//  SCPinViewController
//
//  Created by Maxim Kolesnik on 16.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCPinView : UIView
@property (nonatomic, strong) UIColor *fillColor;
@property (nonatomic, strong) UIColor *highlightedColor;
@property (nonatomic, strong) UIColor *strokeColor;
@property (nonatomic, assign) CGFloat strokeWidth;
@property (nonatomic, assign) BOOL highlighted;
@end
