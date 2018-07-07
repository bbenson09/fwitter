# Twitter

### Starter project
The starter project can be found in the `starter-project` tag. Download and run `pod install`.


### Notes
https://paper.dropbox.com/doc/Twitter--ADuVCVvwop_njSNAbUU96Q2VAQ-g255BPX3K4X7G0reYOWCI

# Project 4 - *Fwitter*

**Fwitter** (as in "fake Twitter") is a basic twitter app to read and compose tweets the [Twitter API](https://apps.twitter.com/).

Time spent: **20** hours spent in total

## User Stories

The following **required** functionality is completed:

- [X ] User sees app icon in home screen and styled launch screen
- [X] User can sign in using OAuth login flow
- [X ] User can Logout
- [X] User can view last 20 tweets from their home timeline
- [X ] In the home timeline, user can view tweet with the user profile picture, username, tweet text, and timestamp.
- [X ] User can pull to refresh.
- [X ] User can tap the retweet and favorite buttons in a tweet cell to retweet and/or favorite a tweet.
- [X ] User can compose a new tweet by tapping on a compose button.
- [X ] Using AutoLayout, the Tweet cell should adjust it's layout for iPhone 7, Plus and SE device sizes as well as accommodate device rotation.
- [X ] The current signed in user will be persisted across restarts

The following **optional** features are implemented:

- [ ] Tweet Details Page: User can tap on a tweet to view it, with controls to retweet, favorite, and reply.
- [ ] User can view their profile in a *profile tab*
- [X] Contains the user header view: picture and tagline
- [X] Contains a section with the users basic stats: # tweets, # following, # followers
- [ ] Profile view should include that user's timeline
- [X ] User should display the relative timestamp for each tweet "8m", "7h"
- [X ] User should be able to unretweet and unfavorite and should decrement the retweet and favorite count. Refer to [[this guide|unretweeting]] for help on implementing unretweeting.
- [ ] Links in tweets are clickable.
- [X ] User can tap the profile image in any tweet to see another user's profile
- [X] Contains the user header view: picture and tagline
- [X] Contains a section with the users basic stats: # tweets, # following, # followers
- [X ] User can load more tweets once they reach the bottom of the feed using infinite loading similar to the actual Twitter client.
- [ ] When composing, you should have a countdown for the number of characters remaining for the tweet (out of 140) (**1 point**)
- [X ] After creating a new tweet, a user should be able to view it in the timeline immediately without refetching the timeline from the network.
- [X ] User can reply to any tweet, and replies should be prefixed with the username and the reply_id should be set when posting the tweet (**2 points**)
- [ ] User sees embedded images in tweet if available 
- [ ] User can switch between timeline, mentions, or profile view through a tab bar (**3 points**)
- [ ] Profile Page: pulling down the profile page should blur and resize the header image. (**4 points**)
