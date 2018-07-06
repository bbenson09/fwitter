//
//  User.h
//  twitter
//
//  Created by Bevin Benson on 7/2/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface User : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *screenName;
@property (strong, nonatomic) NSURL *profilePicLink;
@property (strong, nonatomic) NSString *userDescription;
@property (strong, nonatomic) NSString *numberTweets;
@property (strong, nonatomic) NSString *numberFollowers;
@property (strong, nonatomic) NSString *numberFollowing;

- (instancetype)initWithDictionary:(NSDictionary *)dictionary;

@end
