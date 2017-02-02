//
//  TweetListViewController.m
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import "TweetListViewController.h"
#import "TweetTableViewCell.h"
#import "TwitterClient.h"
#import "NavigationManager.h"

@interface TweetListViewController () <UITableViewDataSource>

@property (weak, nonatomic) IBOutlet UITableView *tweetListTableView;

@end

@implementation TweetListViewController
NSString *tableReuseID = @"tweetTableViewCell";

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.

    self.tweetListTableView.dataSource = self;
    self.tweetListTableView.estimatedRowHeight = 200;
    self.tweetListTableView.rowHeight = UITableViewAutomaticDimension;
    
    UINib *nib = [UINib nibWithNibName:@"TweetTableViewCell" bundle:nil];
    [self.tweetListTableView registerNib:nib forCellReuseIdentifier:tableReuseID];

    UIBarButtonItem *back = [[UIBarButtonItem alloc] initWithTitle:@"Sign Out" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
    self.navigationItem.leftBarButtonItem = back;

}

- (void) reloadData {
    __weak TweetListViewController *weakSelf = self;
    NSString *timelineString = [NSString stringWithFormat:@"1.1/statuses/%@_timeline.json", self.timelineName];
    [[TwitterClient sharedInstance] GET:timelineString parameters:nil progress:^(NSProgress * _Nonnull downloadProgress) {
        // no code
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        weakSelf.tweets = [Tweet tweetsWithArray:responseObject];
        [weakSelf.tweetListTableView reloadData];
        weakSelf.title = self.timelineName;

    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"Failed to get %@ timeline", self.timelineName);
    }];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.tweets.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    TweetTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:tableReuseID forIndexPath:indexPath];

    Tweet *model = [self.tweets objectAtIndex:indexPath.row];
    cell.model = model;
    [cell reloadData];

    return cell;
}

- (void) logout {
    [[TwitterClient sharedInstance] logout];
    [[NavigationManager shared] logout];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
