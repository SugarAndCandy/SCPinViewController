//
//  SCPinViewController.m
//  SCPinViewController
//
//  Created by Maxim Kolesnik on 15.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//


#import "SCPinViewController.h"
#import "SCPinButton.h"
#import "SCPinView.h"
#import "SCPinAppearance.h"
#import <AudioToolbox/AudioToolbox.h>
#import <LocalAuthentication/LocalAuthentication.h>

static SCPinAppearance *appearance;


@interface SCPinViewController ()
@property (nonatomic, strong) SCPinAppearance *appearance;


@property (weak, nonatomic) IBOutlet UIButton *touchIDButton;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *supportLabel;
@property (strong, nonatomic) IBOutletCollection(SCPinButton) NSArray *numberButtons;
@property (weak, nonatomic) IBOutlet UIButton *deleteButton;
@property (weak, nonatomic) IBOutlet UIView *viewForPins;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewForPinsLayoutConstraint;

@property (nonatomic, strong) NSString *currentPin;
@property (nonatomic, assign) BOOL enable;
@property (nonatomic, assign) BOOL touchIDPassedValidation;
@end

@implementation SCPinViewController

#pragma mark - Public

+ (SCPinAppearance *)appearance {
    return appearance;
}

+ (void)setNewAppearance:(SCPinAppearance *)newAppearance {
    appearance = newAppearance;
}

#pragma mark - initialization

- (instancetype)initWithScope:(SCPinViewControllerScope)scope {
    NSBundle *budle = [NSBundle bundleForClass:[SCPinViewController class]];
    NSLog(@"%@", budle);
    self = [super initWithNibName:NSStringFromClass([SCPinViewController class]) bundle:budle];
    if (self) {
        _scope = scope;
        if (!appearance) {
            appearance = [SCPinAppearance defaultAppearance];
        }
        _appearance = appearance;


    }
    return self;
}

#pragma mark - View life cycle

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configureView];
    
    [self setupInitialState];
    [self clearCurrentPin];
    [self createPinView];
    
}

-(void)setupInitialState {
    self.enable = YES;
    self.touchIDPassedValidation = NO;
    
    if ([self.dataSource respondsToSelector:@selector(hideTouchIDButtonIfFingersAreNotEnrolled)]) {
        BOOL hideTouchIDButton = [self.dataSource hideTouchIDButtonIfFingersAreNotEnrolled];
        NSError *error   = nil;
        LAContext *context = [[LAContext alloc] init];
        if (hideTouchIDButton) {
            if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
                [self.touchIDButton setHidden:NO];
            } else {
                [self.touchIDButton setHidden:YES];
            }
        } else {
            [self.touchIDButton setHidden:NO];
        }
    }
    
    if (!self.touchIDButton.isHidden) {
        self.touchIDButton.hidden = !appearance.touchIDButtonEnabled;
    }
    if ([self.dataSource respondsToSelector:@selector(showTouchIDVerificationImmediately)]) {
        BOOL immediately = [self.dataSource showTouchIDVerificationImmediately];
        if (immediately) {
            [self touchIDVerification];
        }
    }
    if (self.scope == SCPinViewControllerScopeCreate) {
        [self.touchIDButton setHidden:YES];
    }
}

-(void)configureView {
    for (SCPinButton *button in self.numberButtons) {
        [button setTintColor:_appearance.numberButtonColor];
        [button setTitleColor:_appearance.numberButtonTitleColor forState:UIControlStateNormal];
        [button setTitleColor:_appearance.numberButtonTitleColor forState:UIControlStateSelected];
        [button setTitleColor:_appearance.numberButtonTitleColor forState:UIControlStateHighlighted];
        button.strokeColor = _appearance.numberButtonStrokeColor;
        button.strokeWidth = _appearance.numberButtonStrokeWitdh;
        button.strokeColor = _appearance.numberButtonstrokeEnabled ? [_appearance numberButtonStrokeColor] : [UIColor clearColor];
        [button.titleLabel setFont:_appearance.numberButtonFont];
        [button setNeedsDisplay];
    }
    
    NSBundle *bundle = [NSBundle bundleForClass:[SCPinViewController class]];

    UIImage *deleteButtonImage = [UIImage imageNamed:@"sc_img_delete" inBundle:bundle compatibleWithTraitCollection:nil];
    [self.deleteButton setImage:deleteButtonImage forState:UIControlStateNormal];
    
    UIImage *touchIDButtonImage = [UIImage imageNamed:@"sc_img_touchid" inBundle:bundle compatibleWithTraitCollection:nil];
    [self.touchIDButton setImage:touchIDButtonImage forState:UIControlStateNormal];

    [self.deleteButton setTintColor:_appearance.deleteButtonColor];
    [self.touchIDButton setTintColor:_appearance.touchIDButtonColor];

    self.titleLabel.text = _appearance.titleText;
    self.titleLabel.font = _appearance.titleTextFont;
    self.titleLabel.textColor = _appearance.titleTextColor;
    
    self.supportLabel.text = _appearance.supportText;
    self.supportLabel.font = _appearance.supportTextFont;
    self.supportLabel.textColor = _appearance.supportTextColor;
    
    self.touchIDButton.hidden = !appearance.touchIDButtonEnabled;

}


-(void)clearCurrentPin {
    self.currentPin = @"";
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


-(void)viewWillLayoutSubviews {
    [super viewWillLayoutSubviews];
    [self createPinView];

}

-(void)viewDidLayoutSubviews {
    [super viewDidLayoutSubviews];
}

#pragma mark - Controller logic

-(void)createPinView {
    NSInteger length;
    NSInteger currentPinLength = [self.currentPin length];
    switch (self.scope) {
        case SCPinViewControllerScopeCreate: {
            length = [self.createDelegate lengthForPin];
            break;
        }
        case SCPinViewControllerScopeValidate: {
            NSString *pin = [self.dataSource codeForPinViewController:self];
            length = [pin length];
            break;
        }
        default:
            break;
    }
    
    CGFloat width = _appearance.pinSize.width;
    CGFloat distance = 15.0f;
    
    CGFloat pinWidth = (length * width) + ((length - 1) * distance);
    CGFloat center = CGRectGetWidth(self.viewForPins.frame) / 2;
    CGFloat x = center - (pinWidth / 2);
    
    for (UIView *view in self.viewForPins.subviews) {
        [view removeFromSuperview];
    }
    
    for (NSInteger index = 0; index<length; index++) {
        SCPinView *view = [[SCPinView alloc]initWithFrame:CGRectMake(x, 0, _appearance.pinSize.width, _appearance.pinSize.height)];
        
        view.fillColor = _appearance.pinFillColor;
        view.highlightedColor = _appearance.pinHighlightedColor;
        view.strokeColor = _appearance.pinStrokeColor;
        view.strokeWidth = _appearance.pinStrokeWidth;
        
        if (self.touchIDPassedValidation) {
            view.highlighted = YES;
        } else if (currentPinLength <= index) {
            view.highlighted = NO;
        } else {
            view.highlighted = YES;
        }
        
        [self.viewForPins addSubview:view];
        x+= (distance + width);
    }
}

- (void)appendingPincode:(NSString *)pincode {
    NSString * appended = [self.currentPin stringByAppendingString:pincode];
    NSUInteger length;
    switch (self.scope) {
        case SCPinViewControllerScopeCreate: {
            length = MIN([appended length], [self.createDelegate lengthForPin]);
            break;
        }
        case SCPinViewControllerScopeValidate: {
            length = MIN([appended length], [[self.dataSource codeForPinViewController:self] length]);
            break;
        }
        default:
            break;
    }
    
    self.currentPin = [appended substringToIndex:length];
    [self createPinView];
}

- (void)removeLastPincode {
    NSUInteger index = ([self.currentPin length] - 1);
    if ([self.currentPin length] > index) {
        self.self.currentPin = [self.currentPin substringToIndex:index];
    }
    [self createPinView];
}

-(void)setCurrentPin:(NSString *)currentPin {
    _currentPin = currentPin;
    
    switch (self.scope) {
        case SCPinViewControllerScopeValidate:{
            BOOL equalLength = ([currentPin length] == [[self.dataSource codeForPinViewController:self] length]);
            if (equalLength) {
                [self validatePin:currentPin];
            }
            break;
        }
        case SCPinViewControllerScopeCreate: {
            if ([currentPin length] == [self.createDelegate lengthForPin]) {
                [self.createDelegate pinViewController:self didSetNewPin:currentPin];
            }
            break;
        }
        default:
            break;
    }
}

-(void)validatePin:(NSString *)pin {
    if ([[self.dataSource codeForPinViewController:self] isEqualToString:pin]) {
        [self correctPin];
        
    } else {
        [self wrongPin];
    }
}

-(void)correctPin {
    if ([self.validateDelegate respondsToSelector:@selector(pinViewControllerDidSetСorrectPin:)]) {
        [self.validateDelegate pinViewControllerDidSetСorrectPin:self];
    }
}

- (void)wrongPin {
    __weak SCPinViewController *weakSelf = self;
    self.enable = NO;
    NSTimeInterval delay = 0.25f;
    dispatch_time_t delayInSeconds = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(delay * NSEC_PER_SEC));
    dispatch_after(delayInSeconds, dispatch_get_main_queue(), ^(void){
        __strong SCPinViewController *strongSelf = weakSelf;
        AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);
        CAAnimation * shake = [self makeShakeAnimation];
        [strongSelf.viewForPins.layer addAnimation:shake forKey:@"shake"];
        if ([strongSelf.validateDelegate respondsToSelector:@selector(pinViewControllerDidSetWrongPin:)]) {
            [strongSelf.validateDelegate pinViewControllerDidSetWrongPin:strongSelf];
        }
        [strongSelf clearCurrentPin];
        [strongSelf createPinView];
        strongSelf.enable = YES;
    });
    
}

- (CAAnimation *)makeShakeAnimation {
    CAKeyframeAnimation * shake = [CAKeyframeAnimation animationWithKeyPath:@"transform.translation.x"];
    [shake setTimingFunction:[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionLinear]];
    [shake setDuration:0.5f];
    [shake setValues:@[ @(-20), @(20), @(-15), @(15), @(-10), @(10), @(-5), @(5), @(0) ]];
    return shake;
}


- (void)touchIDVerification {
    
    NSError   * error   = nil;
    LAContext * context = [[LAContext alloc] init];
    
    if ([context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error]) {
        __weak SCPinViewController *weakSelf = self;
        [context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:_appearance.touchIDVerification
                          reply:^(BOOL success, NSError * authenticationError) {
                              if (success) {
                                  __strong SCPinViewController *strongSelf = weakSelf;

                                  dispatch_async(dispatch_get_main_queue(), ^{
                                      strongSelf.touchIDPassedValidation = YES;
                                      [strongSelf createPinView];
                                      if ([strongSelf.validateDelegate respondsToSelector:@selector(pinViewControllerDidSetСorrectPin:)]) {
                                          [strongSelf.validateDelegate pinViewControllerDidSetСorrectPin:strongSelf];
                                      }
                                  });
                              } else {
                                  NSLog(@"Authentication Error: %@", authenticationError);
                              }
                          }];
    } else {
        NSLog(@"Policy Error: %@", [error localizedDescription]);
    }
    
}

#pragma mark - Actions

- (IBAction)tapPinButtonAction:(SCPinButton *)sender {
    if (!self.enable) {
        return;
    }
    NSInteger number = [sender tag];
    [self appendingPincode:[@(number) description]];
    AudioServicesPlaySystemSound(0x450);

}

- (IBAction)touchIDButtonAction:(UIButton *)sender {
    [self touchIDVerification];
}

- (IBAction)deleteButtonAction:(UIButton *)sender {
    [self removeLastPincode];
    AudioServicesPlaySystemSound(0x450);

}

@end
