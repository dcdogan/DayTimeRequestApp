//
//  DTViewController.h
//  DayTimeRequestApp
//
//  Created by DoganCan on 9/27/13.
//  Copyright (c) 2013 Dogan Can Dogan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DTViewController : UIViewController

- (IBAction)dismissKeyboardOnReturn:(id)sender;

@property (strong, nonatomic) IBOutlet UITextField *hostNameLabel;

- (IBAction)sendTimeRequest:(id)sender;

@property (strong, nonatomic) IBOutlet UITextView *displayTheTimeResponse;
@end
