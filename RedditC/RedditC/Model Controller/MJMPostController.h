//
//  MJMPostController.h
//  RedditC
//
//  Created by Mitch Merrell on 8/21/19.
//  Copyright © 2019 Mitch Merrell. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
@class MJMPost;

NS_ASSUME_NONNULL_BEGIN

@interface MJMPostController : NSObject

+ (instancetype) shared;

- (void) searchForPostsWith:(NSString *)searchTerm completion: (void(^) (NSArray<MJMPost *> *posts, NSError *error))completion;

- (void) fetchImageFor:(MJMPost *)image completion: (void (^) (UIImage *postImage))completion;

@end

NS_ASSUME_NONNULL_END
