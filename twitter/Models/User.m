//
//  User.m
//  twitter
//
//  Created by Bevin Benson on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "User.h"

@implementation User

- (instancetype)initWithDictionary:(NSDictionary *)dictionary {
    
    self = [super init];
    if (self) {
        
        self.name = dictionary[@"name"];
        self.screenName = dictionary[@"screen_name"];
        
        NSString *picUrlString = dictionary[@"profile_image_url_https"];
        NSURL *picUrl = [[NSURL alloc] initWithString:picUrlString];
        
        self.profilePicLink = picUrl;
        self.userDescription = dictionary[@"description"];
        self.numberTweets = [NSString stringWithFormat:@"%@", dictionary[@"statuses_count"]];
        self.numberFollowers = [NSString stringWithFormat:@"%@", dictionary[@"followers_count"]];
        self.numberFollowing = [NSString stringWithFormat:@"%@", dictionary[@"friends_count"]];
        
    }
    
    return self;
}

@end
