//
//  ComposeViewController.m
//  TwitterClient
//
//  Created by  Michael Friedman on 2/2/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import "ComposeViewController.h"
#import "TwitterClient.h"
#import <AFNetworking/UIImageView+AFNetworking.h>

@interface ComposeViewController () <UITextViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *avatarImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *screenNameLabel;
@property (weak, nonatomic) IBOutlet UITextView *tweetText;
@property (weak, nonatomic) UIBarButtonItem *countBarButton;

@end

@implementation ComposeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    if (self.model) {
        self.nameLabel.text = self.model.name;
        self.screenNameLabel.text = self.model.screenname;
        [self.avatarImageView setImageWithURL:[NSURL URLWithString:self.model.profileImageUrl]];
    }

    if (self.replyToTweet) {
        NSString *replyTo = self.replyToTweet.user.screenname;
        self.tweetText.text = [NSString stringWithFormat:@"@%@ ", replyTo];
    }

    UIBarButtonItem *countButton = [[UIBarButtonItem alloc] initWithTitle:@"140" style:UIBarButtonItemStyleDone target:self action:nil];
    countButton.enabled = NO;
    self.countBarButton = countButton;
    UIBarButtonItem *sendButton = [[UIBarButtonItem alloc] initWithTitle:@"Send" style:UIBarButtonItemStyleDone target:self action:@selector(sendTweet)];
    self.navigationItem.rightBarButtonItems = @[sendButton, countButton];

    self.tweetText.delegate = self;
    [self.tweetText becomeFirstResponder];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void) textViewDidChange:(UITextView *)textView {
    long charsLeft = 140 - textView.text.length;
    self.countBarButton.title = [NSString stringWithFormat:@"%ld", charsLeft];
}

- (void) sendTweet {
    [self.tweetText resignFirstResponder];
    [[TwitterClient sharedInstance] sendTweet:self.tweetText.text inReplyTo:self.replyToTweet.tweetId];
}

@end
