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
    
    self.profilePic.image = nil;
    NSString *profilePicLinkString = self.tweet.user.profilePicLink.absoluteString;
    profilePicLinkString = [profilePicLinkString stringByReplacingOccurrencesOfString:@"_normal" withString:@""];
    NSURL *profilePicURL = [NSURL URLWithString:profilePicLinkString];
    if (profilePicURL != nil) {
        [self.profilePic setImageWithURL:profilePicURL];
    }
    
    self.author.text = self.tweet.user.name;
    self.username.text = [NSString stringWithFormat: @"@%@", self.tweet.user.screenName];
    self.descriptionText.text = self.tweet.user.userDescription;
    self.numTweets.text = self.tweet.user.numberTweets;
    self.numFollowers.text = self.tweet.user.numberFollowers;
    self.numFollowing.text = self.tweet.user.numberFollowing;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


- (IBAction)backButtonClicked:(id)sender {
    
    [self dismissViewControllerAnimated:true completion:nil];
    
}

@end
