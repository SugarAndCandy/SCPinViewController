//
//  SCPinAppearance.m
//  SCPinViewController
//
//  Created by Maxim Kolesnik on 16.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import "SCPinAppearance.h"

@implementation SCPinAppearance


+ (instancetype)defaultAppearance {
    SCPinAppearance *defaultAppearance = [[SCPinAppearance alloc]init];
    return defaultAppearance;
}

- (instancetype)init {
    self = [super init];
    if (self) {
        [self setupDefaultAppearance];
    }
    return self;
}

-(void)setupDefaultAppearance {
    UIColor *defaultColor = [UIColor colorWithRed:46.0f / 255.0f green:192.0f / 255.0f blue:197.0f / 255.0f alpha:1];
    UIFont *defaultFont = [UIFont fontWithName:@"HelveticaNeue-Thin" size:27.0f];
    
    self.numberButtonColor = defaultColor;
    self.numberButtonTitleColor = [UIColor blackColor];
    self.numberButtonStrokeColor = defaultColor;
    self.numberButtonStrokeWitdh = 0.8f;
    self.numberButtonstrokeEnabled = YES;
    self.numberButtonFont = defaultFont;
    
    self.deleteButtonColor = defaultColor;
    
    self.pinFillColor = [UIColor clearColor];
    self.pinHighlightedColor = defaultColor;
    self.pinStrokeColor = defaultColor;
    self.pinStrokeWidth = 0.8f;
    self.pinSize = CGSizeMake(14.0f, 14.0f);
    
    self.touchIDButtonEnabled = YES;
    self.touchIDButtonColor = defaultColor;
    
    self.titleText = @"Enter code";
    self.titleTextFont = defaultFont;
    self.titleTextColor = defaultColor;
    
    self.supportText = nil;
    self.supportTextFont = defaultFont;
    self.supportTextColor = defaultColor;
    
    self.touchIDText = @"Put finger";
    self.touchIDVerification = @"Pincode TouchID";
}


/*
#pragma mark - Setters

-(void)setNumberButtonColor:(UIColor *)numberButtonColor {
    _numberButtonColor = numberButtonColor;
    for (SCPinButton *button in self.numberButtons) {
        [button setTintColor:numberButtonColor];
    }
}

-(void)setNumberButtonTitleColor:(UIColor *)numberButtonTitleColor {
    _numberButtonTitleColor = numberButtonTitleColor;
    for (SCPinButton *button in self.numberButtons) {
        [button setTitleColor:numberButtonTitleColor forState:UIControlStateNormal];
        [button setTitleColor:numberButtonTitleColor forState:UIControlStateSelected];
        [button setTitleColor:numberButtonTitleColor forState:UIControlStateHighlighted];
    }
}

-(void)setNumberButtonStrokeColor:(UIColor *)numberButtonStrokeColor {
    _numberButtonStrokeColor = numberButtonStrokeColor;
    for (SCPinButton *button in self.numberButtons) {
        button.strokeColor = numberButtonStrokeColor;
    }
}

-(void)setNumberButtonStrokeWitdh:(CGFloat)numberButtonStrokeWitdh {
    _numberButtonStrokeWitdh = numberButtonStrokeWitdh;
    for (SCPinButton *button in self.numberButtons) {
        button.strokeWidth = numberButtonStrokeWitdh;
    }
}

-(void)setNumberButtonstrokeEnabled:(BOOL)numberButtonstrokeEnabled {
    _numberButtonstrokeEnabled = numberButtonstrokeEnabled;
    for (SCPinButton *button in self.numberButtons) {
        button.strokeColor = numberButtonstrokeEnabled ? [self numberButtonStrokeColor] : [UIColor clearColor];
    }
}

-(void)setNumberButtonFont:(UIFont *)numberButtonFont {
    _numberButtonFont = numberButtonFont;
    for (SCPinButton *button in self.numberButtons) {
        [button.titleLabel setFont:numberButtonFont];
        [button setNeedsDisplay];
    }
}

-(void)setDeleteButtonColor:(UIColor *)deleteButtonColor {
    _deleteButtonColor = deleteButtonColor;
    [self.deleteButton setTintColor:deleteButtonColor];
    //[self.deleteButton.titleLabel setTintColor:deleteButtonColor];
    
}

-(void)setDeleteButtonText:(NSString *)deleteButtonText {
    _deleteButtonText = deleteButtonText;
    //[self.deleteButton setTitle:deleteButtonText forState:UIControlStateNormal];
    //[self.deleteButton setTitle:deleteButtonText forState:UIControlStateSelected];
    //[self.deleteButton setTitle:deleteButtonText forState:UIControlStateHighlighted];
}

-(void)setDeleteButtonFont:(UIFont *)deleteButtonFont {
    _deleteButtonFont = deleteButtonFont;
    [self.deleteButton.titleLabel setFont:deleteButtonFont];
}

-(void)setPinFillColor:(UIColor *)pinFillColor {
    _pinFillColor = pinFillColor;
}

-(void)setPinHighlightedColor:(UIColor *)pinHighlightedColor {
    _pinHighlightedColor = pinHighlightedColor;
}

-(void)setPinStrokeColor:(UIColor *)pinStrokeColor {
    _pinStrokeColor = pinStrokeColor;
}

-(void)setPinStrokeWidth:(CGFloat)pinStrokeWidth {
    _pinStrokeWidth = pinStrokeWidth;
}

-(void)setPinSize:(CGSize)pinSize {
    _pinSize = pinSize;
    self.viewForPinsLayoutConstraint.constant = pinSize.height;
}

-(void)setTouchIDButtonEnabled:(BOOL)touchIDButtonEnabled {
    _touchIDButtonEnabled = touchIDButtonEnabled;
}

-(void)setTouchIDButtonColor:(UIColor *)touchIDButtonColor {
    _touchIDButtonColor = touchIDButtonColor;
    [self.touchIDButton setTintColor:touchIDButtonColor];
}

-(void)setTitleText:(NSString *)titleText {
    _titleText = titleText;
    self.titleLabel.text = titleText;
}

-(void)setTitleTextFont:(UIFont *)titleTextFont {
    _titleTextFont = titleTextFont;
    self.titleLabel.font = titleTextFont;
}

-(void)setTitleTextColor:(UIColor *)titleTextColor {
    _titleTextColor = titleTextColor;
    self.titleLabel.textColor = titleTextColor;
    
}
-(void)setSupportText:(NSString *)supportText {
    _titleText = supportText;
    self.supportLabel.text = supportText;
}

-(void)setSupportTextFont:(UIFont *)supportTextFont {
    _titleTextFont = supportTextFont;
    self.supportLabel.font = supportTextFont;
}

-(void)setSupportTextColor:(UIColor *)supportTextColor {
    _titleTextColor = supportTextColor;
    self.supportLabel.textColor = supportTextColor;
    
} */


@end
