//
//  MJMPost.m
//  RedditC
//
//  Created by Mitch Merrell on 8/21/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

#import "MJMPost.h"

@implementation MJMPost

- (instancetype)initWithTitle:(NSString *)title ups:(NSNumber *)ups commentCount:(NSNumber *)commentCount image:(NSString *)image bodyText:(NSString *)bodyText;
{
    self = [super init];
    if (self)
    {
        _title = title;
        _ups = ups;
        _commentCount = commentCount;
        _image = image;
        _bodyText = bodyText;
    }
    return self;
}
@end

@implementation MJMPost (jsonConvertable)

- (instancetype)initWithDictionary:(NSDictionary *)dictionary
{
    // consider using magic strings
    // This dictionary is the data
    NSDictionary *dataDictionary = dictionary[@"data"];

    //Digging deeper to init our object
    // Get the actual properties from the JSON
    
    NSString *title = dataDictionary[[MJMPost titleKey]];
    NSNumber *ups = dataDictionary[[MJMPost upsKey]];
    NSNumber *commentCount = dataDictionary[[MJMPost commentsKey]];
    NSString *image = dataDictionary[[MJMPost imageKey]];
    NSString *bodyText = dataDictionary[[MJMPost bodyKey]];
    
    // similar to Swift -
    // let post = Post(title: String, commentCount: Int, ups: Int)
    // turn your json properties into your object
    return [self initWithTitle:title ups:ups commentCount:commentCount image:image bodyText:bodyText];
}

+ (NSString *) titleKey { return @"title";};
+ (NSString *) upsKey { return @"ups";};
+ (NSString *) commentsKey { return @"num_comments";};
+ (NSString *) imageKey { return @"thumbnail";};
+ (NSString *) bodyKey { return @"selftext";};

@end
