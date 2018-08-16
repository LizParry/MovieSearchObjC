//
//  EPMovie.m
//  MovieSearchObjC
//
//  Created by Liz Parry on 8/3/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

#import "EPMovie.h"

@implementation EPMovie

@end

@implementation EPMovie (JSONConvertible)

- (instancetype)initWithDictionary:(NSDictionary *)JSONDictionary
{
    NSString *title = JSONDictionary[@"original_title"];
    NSNumber *rating = JSONDictionary[@"vote_average"];
    NSString *summary = JSONDictionary[@"overview"];
    NSString *imageURLAsString = @" ";
    NSLog(@"%@", title);
    
    if (![JSONDictionary[@"poster_path"] isEqual:[NSNull null]]) {
        imageURLAsString = JSONDictionary[@"poster_path"];
    }
    
    self = [super init];
    if (self) {
        _title = [title copy];
        _rating = rating;
        _summary = [summary copy];
        _imageURLAsString = [imageURLAsString copy];
    }
    return self;
}
@end
