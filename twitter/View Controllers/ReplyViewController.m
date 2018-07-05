//
//  ReplyViewController.m
//  twitter
//
//  Created by Bevin Benson on 7/5/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ReplyViewController.h"
#import "APIManager.h"

@interface ReplyViewController ()

@property (weak, nonatomic) IBOutlet UITextView *textView;


@end

@implementation ReplyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)closeButtonTapped:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}

- (IBAction)replyButtonTapped:(id)sender {
    
    [[APIManager shared] postReplyWithText:self.textView.text :self.tweet completion:^(Tweet *tweet, NSError *error) {
        
        [self dismissViewControllerAnimated:true completion:nil];
        
        if(error){
            NSLog(@"Error replying to Tweet: %@", error.localizedDescription);
        }
        else {
            NSLog(@"Replying to Tweet Success!");
        }
    }];
    
    
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
