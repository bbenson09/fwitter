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

@interface TimelineViewController () <ComposeViewControllerDelegate, UITableViewDataSource, UITableViewDelegate>

@property (weak, nonatomic) IBOutlet UITableView *mainTableView;
@property NSMutableArray *tweetArray;
@property UIRefreshControl *refreshControl;

@end

@implementation TimelineViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.mainTableView.dataSource = self;
    self.mainTableView.delegate = self;
    
    // Initializes refresh control
    self.refreshControl = [[UIRefreshControl alloc] init];

    // Get timeline
    [self fetchTimeline];
    
    self.refreshControl = [[UIRefreshControl alloc] init];
    [self.refreshControl addTarget:self action:@selector(fetchTimeline) forControlEvents:UIControlEventValueChanged];
    [self.mainTableView insertSubview:self.refreshControl atIndex:0];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    // Get timeline
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

#pragma mark - Navigation



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

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    if ([[segue identifier] isEqualToString:@"showComposeStoryboard"]) {
        
        UINavigationController *navigationController = [segue destinationViewController];
        ComposeViewController *composeController = (ComposeViewController *)navigationController.topViewController;
        composeController.delegate = self;
    
    }
    else if ([[segue identifier] isEqualToString:@"showReplyStoryboard"]) {
        
        NSIndexPath *indexPath = [self.mainTableView indexPathForSelectedRow];
        UINavigationController *destViewController = [segue destinationViewController];
        // Tweet *thisTweet = self.tweetArray[indexPath.row];
        ReplyViewController *replyController = (ReplyViewController *)destViewController.topViewController;
        replyController.tweet = self.tweetArray[indexPath.row];
        
    }
    
    
}








@end
