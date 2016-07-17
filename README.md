<h1 align="center"> SCPinViewController </h1>

<p align="center">
<img src="https://img.shields.io/cocoapods/p/DeepLinkSDK.svg?style=flat" alt="Platform" /></a>
</p>

Overview
-------------
Super customization Pin controller.

Feature
-------------
- Touch ID
- Autolayout
- Cocoapods
- Customization

### Installation with CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Objective-C, which automates and simplifies the process of using 3rd-party libraries like SCPinViewController in your projects. See the ["Getting Started" guide for more information].


#### Podfile

```ruby
platform :ios, '8.0'
pod 'SCPinViewController'

```


### Usage for validate

```
// Import the class
#import <SCPinViewController/SCPinViewController.h>

...

- (void)showPinAction:(UIButton *)sender {
    SCPinViewController *vc = [[SCPinViewController alloc] initWithScope:SCPinViewControllerScopeValidate];

    vc.dataSource = self;
    vc.validateDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

-(NSString *)codeForPinViewController:(SCPinViewController *)pinViewController {
    return @"1234";
}


-(void)pinViewControllerDidSetWrongPin:(SCPinViewController *)pinViewController {
	NSLog(@"Wrong")
}

-(void)pinViewControllerDidSetСorrectPin:(SCPinViewController *)pinViewController{
    [self dismissViewControllerAnimated:YES completion:nil];

}

...

```

### Usage for create

```
// Import the class
#import <SCPinViewController/SCPinViewController.h>

...

- (void)showPinAction:(UIButton *)sender {
    SCPinViewController *vc = [[SCPinViewController alloc] initWithScope:SCPinViewControllerScopeCreate];
    vc.createDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

-(void)pinViewController:(SCPinViewController *)pinViewController didSetNewPin:(NSString *)pin {
    NSLog(@"pinViewController: %@",pinViewController);
    [[NSUserDefaults standardUserDefaults] setObject:pin forKey:kViewControllerPin];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [self dismissViewControllerAnimated:YES completion:nil];
}

...

```


### Apply custom appearance

```
// Import the class
#import <SCPinViewController/SCPinViewController.h>
#import <SCPinViewController/SCPinAppearance.h>

...

- (void)showPinAction:(UIButton *)sender {
    SCPinAppearance *appearance = [SCPinAppearance defaultAppearance];
    
    appearance.titleText = @"Enter PIN";
    appearance.numberButtonStrokeWitdh = 1.0f;
    appearance.pinSize = CGSizeMake(8.0f, 8.0f);
    [SCPinViewController setNewAppearance:appearance];

    SCPinViewController *vc = [[SCPinViewController alloc] initWithScope:SCPinViewControllerScopeValidate];

    vc.dataSource = self;
    vc.validateDelegate = self;
    [self presentViewController:vc animated:YES completion:nil];
}

-(NSString *)codeForPinViewController:(SCPinViewController *)pinViewController {
    return @"1234";
}


-(void)pinViewControllerDidSetWrongPin:(SCPinViewController *)pinViewController {
	NSLog(@"Wrong")
}

-(void)pinViewControllerDidSetСorrectPin:(SCPinViewController *)pinViewController{
    [self dismissViewControllerAnimated:YES completion:nil];

}

...

```


![DropAlert](https://github.com/SugarAndCandy/SCPinViewController/blob/master/Screen.png)


License
-------------------------------------------------------
The MIT License (MIT)

Copyright (c) 2016 Sugar and Candy

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in all
copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
SOFTWARE.
