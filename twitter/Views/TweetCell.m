//
//  TweetCell.m
//  twitter
//
//  Created by Bevin Benson on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TweetCell.h"

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

}

@end
