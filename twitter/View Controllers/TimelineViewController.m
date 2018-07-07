//
//  TimelineViewController.m
//  twitter
//
//  Created by emersonmalca on 5/28/18.
//  Copyright © 2018 Emerson Malca. All rights reserved.
//

#import "TimelineViewController.h"
#import "APIManager.h"
#import "Tweet.h"
#import "TweetCell.h"
#import "ComposeViewController.h"
#import "AppDelegate.h"
#import "LoginViewController.h"
#import "ReplyViewController.h"
#import "ProfileViewController.h"

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate, UIScrollViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property NSMutableArray *tweetArray;
@property UIRefreshControl *refreshControl;
@property (assign, nonatomic) BOOL isMoreDataLoading;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    
    self.refreshControl = [[UIRefreshControl alloc] init];

    [self fetchTimeline];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTimeline) forControlEvents:UIControlEventValueChanged];
    [self.mainTableView insertSubview:self.refreshControl atIndex:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return self.tweetArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    TweetCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TweetCell" forIndexPath:indexPath];
    
    cell.tweet = self.tweetArray[indexPath.row];
    
    return cell;
}

- (void)fetchTimeline {
    
    [[APIManager shared] getHomeTimelineWithCompletion:^(NSArray *tweets, NSError *error) {
        if (tweets) {
            NSLog(@"😎😎😎 Successfully loaded home timeline");
            self.tweetArray = [NSMutableArray arrayWithArray:tweets];
            [self.mainTableView reloadData];
        } else {
            NSLog(@"😫😫😫 Error getting home timeline: %@", error.localizedDescription);
        }
    }];
    
    [self.refreshControl endRefreshing];
    
}

- (void)didTweet:(Tweet *)tweet {
    
    [self.tweetArray insertObject:tweet atIndex:0];
    [self.mainTableView reloadData];

}

- (IBAction)logoutButtonTapped:(id)sender {
    
    AppDelegate *appDelegate = (AppDelegate *)[UIApplication sharedApplication].delegate;
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
    LoginViewController *loginViewController = [storyboard instantiateViewControllerWithIdentifier:@"LoginViewController"];
    
    appDelegate.window.rootViewController = loginViewController;
    
    [[APIManager shared] logout];
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    
    if ([[segue identifier] isEqualToString:@"showComposeStoryboard"]) {
        
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController *)navigationController.topViewController;
        composeController.delegate = self;
    
    }
    else if ([[segue identifier] isEqualToString:@"showReplyStoryboard"]) {
        
        NSIndexPath *indexPath = [self.mainTableView indexPathForSelectedRow];
        UINavigationController *destViewController = [segue destinationViewController];
        ReplyViewController *replyController = (ReplyViewController *)destViewController.topViewController;
        replyController.tweet = self.tweetArray[indexPath.row];
        
    }

    else if ([[segue identifier] isEqualToString:@"showProfileStoryboard"]) {
        
        NSIndexPath *indexPath = [self.mainTableView indexPathForSelectedRow];
        UINavigationController *destViewController = [segue destinationViewController];
        ProfileViewController *profileController = (ProfileViewController *)destViewController.topViewController;
        profileController.tweet = self.tweetArray[indexPath.row];
    }

    
    
}

- (void) scrollViewDidScroll:(UIScrollView *)scrollView {
    
    if (!self.isMoreDataLoading) {
        
        int scrollViewContentHeight = self.mainTableView.contentSize.height;
        int scrollOffsetThreshold = scrollViewContentHeight - self.mainTableView.bounds.size.height;
        
        if(scrollView.contentOffset.y > scrollOffsetThreshold && self.mainTableView.isDragging) {
            
            self.isMoreDataLoading = true;
            
            
            Tweet *lastTweet = self.tweetArray.lastObject;
            [[APIManager shared] loadMoreDataWithCompletion:lastTweet completion:^(NSArray *tweets, NSError *error) {
                
                if(tweets){
                    NSLog(@"Successfully loaded more data");
                    [self.tweetArray addObjectsFromArray:tweets];
                    [self.mainTableView reloadData];
                }
                else{
                    
                    NSLog(@"Error loading more data: %@", error.localizedDescription);
                }
            }];
        }
    }
}
@end
