//
//  TweetCell.m
//  twitter
//
//  Created by Bevin Benson on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"
#import "TweetCell.m"
#import "UIImageView+AFNetworking.h"

@implementation TweetCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
    
}

- (void)setTweet:(Tweet *)tweet {
    
    _tweet = tweet;
    
    self.author.text = self.tweet.user.name;
    self.tweetText.text = self.tweet.text;
    self.username.text = self.tweet.user.screenName;
    self.date.text = self.tweet.createdAtString;
    self.retweetCount.text = [[NSNumber numberWithInt:self.tweet.retweetCount] stringValue];
    self.favoriteCount.text = [[NSNumber numberWithInt:self.tweet.favoriteCount] stringValue];
    
    if (self.tweet.retweeted) {
        [self.retweetButton setSelected:YES];
        self.retweetCount.textColor = [UIColor greenColor];
    }
    else {
        
        [self.retweetButton setSelected:NO];
        self.retweetCount.textColor = [UIColor blackColor];
    }
    
    if (self.tweet.favorited) {
        [self.favoriteButton setSelected:YES];
        self.favoriteCount.textColor = [UIColor redColor];
    }
    else {
        [self.favoriteButton setSelected:NO];
        self.favoriteCount.textColor = [UIColor blackColor];
        
    }
    
    self.profilePic.image = nil;
    if (self.tweet.user.profilePicLink != nil) {
        [self.profilePic setImageWithURL:self.tweet.user.profilePicLink];
    }
}

- (IBAction)retweetButtonTapped:(id)sender {
    
    if (!self.tweet.retweeted) {
        
        self.tweet.retweeted = YES;
        self.tweet.retweetCount += 1;
        
        self.retweetCount.textColor = [UIColor greenColor];
        
        [self.retweetButton setSelected:YES];
        
        [self refreshData];
        
        [[APIManager shared] retweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error retweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully retweeted the following Tweet: %@", tweet.text);
            }
        }];
        
        
    }
    else {
        
        self.tweet.retweeted = NO;
        self.tweet.retweetCount -= 1;
        
        self.retweetCount.textColor = [UIColor blackColor];
        
        [self.retweetButton setSelected:NO];
        
        [self refreshData];
        
        [[APIManager shared] unretweet:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unretweeting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unretweeted the following Tweet: %@", tweet.text);
            }
        }];
    }
}



- (IBAction)favoriteButtonTapped:(id)sender {
    
    if (!self.tweet.favorited) {
        
        // Update local tweet model
        self.tweet.favorited = YES;
        self.tweet.favoriteCount += 1;
        
        self.favoriteCount.textColor = [UIColor redColor];
        
        [self.favoriteButton setSelected:YES];
        
        // Update cell UI
        [self refreshData];
        
        [[APIManager shared] favorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error favoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully favorited the following Tweet: %@", tweet.text);
            }
        }];
        
        
    }
    else {
        
        // Update local tweet model
        self.tweet.favorited = NO;
        self.tweet.favoriteCount -= 1;
        
        self.favoriteCount.textColor = [UIColor blackColor];
        
        [self.favoriteButton setSelected:NO];
        
        // Update cell UI
        [self refreshData];
        
        [[APIManager shared] unfavorite:self.tweet completion:^(Tweet *tweet, NSError *error) {
            if(error){
                NSLog(@"Error unfavoriting tweet: %@", error.localizedDescription);
            }
            else{
                NSLog(@"Successfully unfavorited the following Tweet: %@", tweet.text);
            }
        }];
    }
}

- (void)refreshData {
    
    self.retweetCount.text = [[NSNumber numberWithInt:self.tweet.retweetCount] stringValue];
    self.favoriteCount.text = [[NSNumber numberWithInt:self.tweet.favoriteCount] stringValue];
}






@end
