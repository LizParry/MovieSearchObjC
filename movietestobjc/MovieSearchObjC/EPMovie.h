//
//  EPMovie.h
//  MovieSearchObjC
//
//  Created by Liz Parry on 8/3/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

#import <Foundation/Foundation.h>
NS_ASSUME_NONNULL_BEGIN

@interface EPMovie : NSObject
@property (nonatomic, readonly, copy) NSString *title;
@property (nonatomic, readonly) NSNumber *rating;
@property (nonatomic, readonly, copy) NSString *summary;
@property (nonatomic, readonly, copy, nullable) NSString *imageURLAsString;

NS_ASSUME_NONNULL_END
@end

@interface EPMovie (JSONConvertible)

-(instancetype) initWithDictionary: (NSDictionary *)JSONDictionary;


@end
