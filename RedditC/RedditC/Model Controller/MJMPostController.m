//
//  MJMPostController.m
//  RedditC
//
//  Created by Mitch Merrell on 8/21/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//
#import "MJMPost.h"
#import "MJMPostController.h"

@implementation MJMPostController

+ (MJMPostController *) shared {
    static MJMPostController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [MJMPostController new];
    });
    return shared;
}

+ (NSURL *) baseURL
{
    return [NSURL URLWithString:@"https://www.reddit.com/r"];
}

- (void)searchForPostsWith:(NSString *)searchTerm completion:(void (^)(NSArray<MJMPost *> *, NSError *))completion
{
    // build url
    NSURL *url = [[MJMPostController baseURL] URLByAppendingPathComponent:searchTerm];
    NSURL *finalURL = [url URLByAppendingPathExtension:@"json"];
    NSLog(@"%@", finalURL);
    // NSURLSession
    [[NSURLSession.sharedSession dataTaskWithURL:finalURL completionHandler:^(NSData * data, NSURLResponse * response, NSError * _Nullable error) {
        // can show to users
        if (error)
        {
            NSLog(@"%@", error.localizedDescription);
            return completion(nil, [NSError errorWithDomain:@"Error fetching JSON" code:(NSInteger)-1 userInfo:nil]);
            
        }
        // just for developer
        if (!data) {
            NSLog(@"Error no data returned from the dataTask");
            return completion(nil, [NSError errorWithDomain:@"Error: No Data Returned" code:(NSInteger)-1 userInfo:nil]);
        }
        
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        NSDictionary *dataDictionary = topLevelDictionary[@"data"];
        NSArray *childrenArray = dataDictionary[@"children"];
        
        // Placeholder array
        NSMutableArray *postArray = [[NSMutableArray alloc] init];
        
        for (NSDictionary *postDataDictionary in childrenArray)
        {
            MJMPost *post = [[MJMPost alloc] initWithDictionary:postDataDictionary];
            [postArray addObject:post];
        }
        completion(postArray, nil);
        
    }]resume];
}

- (void)fetchImageFor:(MJMPost *)post completion:(void (^)(UIImage * _Nonnull))completion
{
    NSURL *url = [NSURL URLWithString:post.image];
    
    [[NSURLSession.sharedSession dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error)
        {
            NSLog(@"%@:%@", error, error.localizedDescription);
        }
        if (!data)
        {
            NSLog(@"No data returned. %@", error.localizedDescription);
        }
        
        UIImage *image = [UIImage imageWithData:data];
        completion(image);
    
    }]resume];
}
@end
