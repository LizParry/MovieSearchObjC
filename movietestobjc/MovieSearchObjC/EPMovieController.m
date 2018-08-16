//
//  EPMovieController.m
//  MovieSearchObjC
//
//  Created by Liz Parry on 8/3/18.
//  Copyright © 2018 Liz Parry. All rights reserved.
//

#import "EPMovieController.h"
#import "EPMovie.h"
@implementation EPMovieController


static NSString *baseURLAsString = @"https://api.themoviedb.org/3/search/movie";

+(EPMovieController *)shared
{
    static EPMovieController *shared = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        shared = [EPMovieController new];
    });
    return shared;
}

- (void)getMovieWith:(NSString *)searchTerm completion:(void (^)(BOOL))completion
{
    NSURL *baseURL = [NSURL URLWithString:baseURLAsString];
    NSURLComponents *components = [[NSURLComponents alloc] initWithURL:baseURL resolvingAgainstBaseURL:YES];
    NSURLQueryItem *apiQueryItem = [NSURLQueryItem queryItemWithName: @"api_key" value:@"822e9347ea941381a0ca46de76245189"];
    NSURLQueryItem *movieQueryItem = [NSURLQueryItem queryItemWithName:@"query" value:searchTerm];
    components.queryItems = @[apiQueryItem, movieQueryItem];
    
    NSURL *fullURL = components.URL;
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:fullURL completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"there was an error fetching data: %@", error);
            completion(false);
            return;
        }
        if (!data) {
            completion(false);
            return;
        }
        NSDictionary *topLevelDictionary = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:&error];
        if (topLevelDictionary ==nil) {
            completion(false);
            return;
        }
        NSArray *resultsArray = [topLevelDictionary objectForKey:@"results"];
        NSMutableArray *movies = [NSMutableArray new];
        
        for (NSDictionary *moviesDictionary in resultsArray) {
            EPMovie *movie = [[EPMovie alloc] initWithDictionary:moviesDictionary];
            [movies addObject:movie];
            
        }
        self.movies = movies;
        completion(true);
        return;
    }];
    [dataTask resume];
}

- (void)getMovieImageFrom:(EPMovie *)movie completion:(void (^)(UIImage *))completion
{
    UIImage *notFoundImage = [UIImage imageNamed:@"not_found"];
    if ([[movie imageURLAsString] isEqualToString:@" "]) {
    completion(notFoundImage);
    return;
    }
    NSURL *baseURLForImage = [NSURL URLWithString:@"http://image.tmdb.org/t/p/w500"];
    NSURL *url  = [baseURLForImage URLByAppendingPathComponent:[movie imageURLAsString]];
    NSURLSessionDataTask *dataTask = [[NSURLSession sharedSession] dataTaskWithURL:url completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
        if (error) {
            NSLog(@"%@", error);
            completion(notFoundImage);
            return;
        }
        if (data == nil) {
            completion(notFoundImage);
            return;
        }
        UIImage *image = [[UIImage alloc] initWithData:data];
        completion(image);
    }];
    [dataTask resume];
}
@end












