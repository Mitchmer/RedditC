//
//  MJMPost.h
//  RedditC
//
//  Created by Mitch Merrell on 8/21/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface MJMPost : NSObject

@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly) NSNumber *ups;
@property (nonatomic, readonly) NSNumber *commentCount;
@property (nonatomic, readonly, copy) NSString *image;
@property (nonatomic, readonly, copy) NSString *bodyText;

// This will initialize our object MJMPost
- (instancetype) initWithTitle:(NSString *)title ups:(NSNumber *)ups commentCount:(NSNumber *)commentCount image:(NSString *)image bodyText:(NSString *)bodyText;

@end

@interface MJMPost (jsonConvertable)

- (instancetype) initWithDictionary:(NSDictionary *)dictionary;

@end


