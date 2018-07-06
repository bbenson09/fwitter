//
//  ProfileViewController.m
//  twitter
//
//  Created by Bevin Benson on 7/6/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "ProfileViewController.h"
#import "UIImageView+AFNetworking.h"

@interface ProfileViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *profilePic;
@property (weak, nonatomic) IBOutlet UILabel *author;
@property (weak, nonatomic) IBOutlet UILabel *username;
@property (weak, nonatomic) IBOutlet UILabel *descriptionText;
@property (weak, nonatomic) IBOutlet UILabel *numTweets;
@property (weak, nonatomic) IBOutlet UILabel *numFollowing;
@property (weak, nonatomic) IBOutlet UILabel *numFollowers;

@end

@implementation ProfileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.profilePic.image = nil;
    if (self.tweet.user.profilePicLink != nil) {
        [self.profilePic setImageWithURL:self.tweet.user.profilePicLink];
    }
    self.author.text = self.tweet.user.name;
    self.username.text = self.tweet.user.screenName;
    self.descriptionText.text = self.tweet.user.userDescription;
    self.numTweets.text = self.tweet.user.numberTweets;
    self.numFollowers.text = self.tweet.user.numberFollowers;
    self.numFollowing.text = self.tweet.user.numberFollowing;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)backButtonClicked:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
    
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
