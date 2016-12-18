//
//  SCPinAppearance.h
//  SCPinViewController
//
//  Created by Maxim Kolesnik on 16.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SCPinAppearance : NSObject
+ (instancetype)defaultAppearance;

@property (nonatomic, strong) UIColor *numberButtonColor;
@property (nonatomic, strong) UIColor *numberButtonTitleColor;
@property (nonatomic, strong) UIColor *numberButtonStrokeColor;
@property (nonatomic, assign) CGFloat numberButtonStrokeWitdh;
@property (nonatomic, assign) BOOL numberButtonstrokeEnabled;
@property (nonatomic, strong) UIFont *numberButtonFont;

@property (nonatomic, strong) UIColor *deleteButtonColor;

@property (nonatomic, strong) UIColor *pinFillColor;
@property (nonatomic, strong) UIColor *pinHighlightedColor;
@property (nonatomic, strong) UIColor *pinStrokeColor;
@property (nonatomic, assign) CGFloat pinStrokeWidth;
@property (nonatomic, assign) CGSize pinSize;

@property (nonatomic, assign) BOOL touchIDButtonEnabled;
@property (nonatomic, strong) UIColor *touchIDButtonColor;

@property (nonatomic, strong) NSString *titleText;
@property (nonatomic, strong) UIColor *titleTextColor;
@property (nonatomic, strong) UIFont *titleTextFont;

@property (nonatomic, strong) NSString *supportText;
@property (nonatomic, strong) UIColor *supportTextColor;
@property (nonatomic, strong) UIFont *supportTextFont;

@property (nonatomic, strong) NSString *touchIDText;
@property (nonatomic, strong) NSString *touchIDVerification;

@end
