//
//  TweetTableViewCell.m
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import "TweetTableViewCell.h"

@interface TweetTableViewCell ()
@property (weak, nonatomic) IBOutlet UIImageView *retweetImageView;
@property (weak, nonatomic) IBOutlet UILabel *retweetFrom;
@property (weak, nonatomic) IBOutlet UIImageView *profileImageView;
@property (weak, nonatomic) IBOutlet UILabel *nameLabel;
@property (weak, nonatomic) IBOutlet UILabel *handleLabel;
@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@end

@implementation TweetTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code

    self.nameLabel.text = @"Twitter Name";
    self.handleLabel.text = @"@frimiccalksdja;sligh;alish;ashga;sh;aksjdh";
    self.timestampLabel.text = @"4h";
    self.contentLabel.text = @"Full tweet goes here.";
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)replyTapped:(id)sender {
}

- (IBAction)retweetTapped:(id)sender {
}

- (IBAction)favoriteTapped:(id)sender {
}

@end
