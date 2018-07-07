//
//  ComposeViewController.m
//  twitter
//
//  Created by Bevin Benson on 7/3/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ComposeViewController.h"
#import "APIManager.h"

@interface ComposeViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)closeButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
}

- (IBAction)tweetButtonTapped:(id)sender {
    
    
    [[APIManager shared] postStatusWithText:self.textView.text completion:^(Tweet *tweet, NSError *error) {
        
        [self dismissViewControllerAnimated:true completion:nil];
        
        if(error){
            NSLog(@"Error composing Tweet: %@", error.localizedDescription);
        }
        else {
            [self.delegate didTweet:tweet];
            NSLog(@"Compose Tweet Success!");
        }
    }];
    
    
}
@end
