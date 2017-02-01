//
//  Tweet.m
//  TwitterClient
//
//  Created by  Michael Friedman on 1/30/17.
//  Copyright © 2017  Michael Friedman. All rights reserved.
//

#import "Tweet.h"

@implementation Tweet

- (id) initWithDictionary:(NSDictionary *)dictionary {
    self = [super init];
    if (self) {
        NSLog(@"tweet data: %@", dictionary);
        self.text = dictionary[@"text"];
        self.user = [[User alloc] initWithDictionary:dictionary[@"user"]];
        if (dictionary[@"retweeted_status"]) {
            self.retweetFrom = [dictionary valueForKeyPath:@"retweeted_status.user.screen_name"];
        }

        // parse date using a dateformatter
        NSString *createdAtString = dictionary[@"created_at"];
        NSDateFormatter *dformatter = [[NSDateFormatter alloc] init];
        dformatter.dateFormat = @"EEE MMM d HH:mm:ss Z y";
        self.createdAt = [dformatter dateFromString:createdAtString];

        NSDateComponentsFormatter *formatter = [[NSDateComponentsFormatter alloc] init];
        formatter.unitsStyle = NSDateComponentsFormatterUnitsStyleAbbreviated;
        formatter.allowedUnits = NSCalendarUnitYear | NSCalendarUnitMonth | NSCalendarUnitDay | NSCalendarUnitHour | NSCalendarUnitMinute | NSCalendarUnitSecond;
        formatter.maximumUnitCount = 1;
        NSString *elapsed = [formatter stringFromDate:self.createdAt toDate:[NSDate date]];
        self.createdAgo = elapsed;

    }
    return self;
}

+ (NSArray *) tweetsWithArray:(NSArray *)array {
    NSMutableArray *tweets = [NSMutableArray array];

    for (NSDictionary *dictionary in array) {
        [tweets addObject:[[Tweet alloc] initWithDictionary:dictionary]];

    }
    return tweets;
}


@end
