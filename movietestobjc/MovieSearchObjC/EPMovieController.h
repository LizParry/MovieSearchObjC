//
//  EPMovieController.h
//  MovieSearchObjC
//
//  Created by Liz Parry on 8/3/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "EPMovie.h"
@interface EPMovieController : NSObject

NS_ASSUME_NONNULL_BEGIN
+ (EPMovieController *)shared;

@property (nonatomic, copy) NSMutableArray *movies; // check to see if array for this website


-(void)getMovieWith: (NSString *)searchTerm
         completion: (void(^)(BOOL))completion;

-(void)getMovieImageFrom: (EPMovie *) movie
              completion: (void(^)(UIImage *))completion;

NS_ASSUME_NONNULL_END
@end
