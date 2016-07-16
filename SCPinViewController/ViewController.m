//
//  ViewController.m
//  SCPinViewController
//
//  Created by Maxim Kolesnik on 15.07.16.
//  Copyright © 2016 Sugar and Candy. All rights reserved.
//

#import "ViewController.h"
#import "SCPinViewController.h"
#import "SCPinAppearance.h"

NSString * const kViewControllerPin = @"kViewControllerPin";

@interface ViewController () <SCPinViewControllerCreateDelegate, SCPinViewControllerDataSource, SCPinViewControllerValidateDelegate>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (IBAction)showPinAction:(UIButton *)sender {
    NSString *pin = [[NSUserDefaults standardUserDefaults] objectForKey:kViewControllerPin];
    SCPinViewController *vc;
    
    SCPinAppearance *appearance = [SCPinAppearance defaultAppearance];
    if (pin.length > 0) {
        appearance.titleText = @"Enter PIN";
        [SCPinViewController setNewAppearance:appearance];
        vc = [[SCPinViewController alloc] initWithScope:SCPinViewControllerScopeValidate];
        
    } else {
        appearance.titleText = @"Create PIN";
        [SCPinViewController setNewAppearance:appearance];
        vc = [[SCPinViewController alloc] initWithScope:SCPinViewControllerScopeCreate];
    }
    
    vc.dataSource = self;
    vc.createDelegate = self;
    vc.validateDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(void)pinViewController:(SCPinViewController *)pinViewController didSetNewPin:(NSString *)pin {
    NSLog(@"pinViewController: %@",pinViewController);
    [[NSUserDefaults standardUserDefaults] setObject:pin forKey:kViewControllerPin];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}

-(NSInteger)lengthForPin {
    return 4;
}

-(NSString *)codeForPinViewController:(SCPinViewController *)pinViewController {
    NSString *pin = [[NSUserDefaults standardUserDefaults] objectForKey:kViewControllerPin];
    return pin;
}

-(BOOL)hideTouchIDButtonIfFingersAreNotEnrolled {
    return YES;
}

-(BOOL)showTouchIDVerificationImmediately {
    return NO;
}

-(void)pinViewControllerDidSetWrongPin:(SCPinViewController *)pinViewController {

}

-(void)pinViewControllerDidSetСorrectPin:(SCPinViewController *)pinViewController{
    [self dismissViewControllerAnimated:YES completion:nil];

}



@end
