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
    SCPinViewController *vc;
    
    SCPinAppearance *appearance = [SCPinAppearance defaultAppearance];
    appearance.numberButtonstrokeEnabled = NO;
    appearance.titleText = @"Enter PIN";
    [SCPinViewController setNewAppearance:appearance];
    vc = [[SCPinViewController alloc] initWithScope:SCPinViewControllerScopeValidate];
    
    vc.dataSource = self;
    vc.validateDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

- (IBAction)createPinAction:(UIButton *)sender {
    SCPinAppearance *appearance = [SCPinAppearance defaultAppearance];
    SCPinViewController *vc;
    
    appearance.titleText = @"Create PIN";
    [SCPinViewController setNewAppearance:appearance];
    vc = [[SCPinViewController alloc] initWithScope:SCPinViewControllerScopeCreate];
    
    vc.createDelegate = self;
    UINavigationController *navigation = [[UINavigationController alloc]initWithRootViewController:vc];
    UIBarButtonItem *item = [[UIBarButtonItem alloc] initWithTitle:@"Cancel" style:UIBarButtonItemStylePlain target:self action:@selector(cancel)];
    [vc.navigationItem setLeftBarButtonItems:@[item]];
    [self presentViewController:navigation animated:YES completion:nil];
}

-(void)cancel {
    [self dismissViewControllerAnimated:YES completion:nil];
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
