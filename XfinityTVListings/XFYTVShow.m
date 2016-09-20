//
//  XFYTVShow.m
//  XfinityTVListings
//
//  Created by Brendon Lavernia on 9/20/16.
//  Copyright © 2016 Comcast. All rights reserved.
//

#import "XFYTVShow.h"
#import "XFYTVShowEpisode.h"

@interface XFYTVShow ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, XFYTVShowEpisode *> *mutableEpisodes;

@end

@implementation XFYTVShow

- (instancetype) initWithTitle:(NSString *)title network:(NSString *)network {
    
    self = [super init];
    
    if (self) {
        _title = title;
        _network = network;
        _mutableEpisodes = [@{} mutableCopy];
    }
    
    return self;
    
}

- (BOOL) insertNewEpisode:(NSString *)episodeName
                   season:(NSString *)season
            episodeNumber:(NSString *)episodeNumber
                 imageURL:(NSString *)imageURL
                 duration:(NSString *)minutes {
    
    BOOL didReplaceEpisode = [self.mutableEpisodes objectForKey:episodeName];
    
    self.mutableEpisodes[episodeName] = [[XFYTVShowEpisode alloc] initWithNetwork:self.network
                                                                             show:self.title
                                                                          episode:episodeName
                                                                           season:season
                                                                    episodeNumber:episodeNumber
                                                                         imageURL:imageURL
                                                                         duration:minutes];
    return didReplaceEpisode;
}

- (NSDictionary<NSString *, XFYTVShowEpisode *> *)episodes {
    return [self.mutableEpisodes copy];
}

- (NSArray<XFYTVShowEpisode *> *) sortedEpisodes {
    NSArray<XFYTVShowEpisode *> *sortedEpisodes = [[self.episodes allValues] sortedArrayUsingComparator:^NSComparisonResult(id  _Nonnull obj1, id  _Nonnull obj2) {
        XFYTVShowEpisode *e1 = (XFYTVShowEpisode *)obj1;
        XFYTVShowEpisode *e2 = (XFYTVShowEpisode *)obj2;
        if ([e1.season integerValue] < [e2.season integerValue]) {
            return NSOrderedAscending;
        } else if ([e1.season integerValue] > [e2.season integerValue]) {
            return NSOrderedDescending;
        } else {
            if ([e1.episodeNumber integerValue] < [e2.episodeNumber integerValue]) {
                return NSOrderedAscending;
            } else {
                return NSOrderedDescending;
            }
        }
        
    }];
    
    return sortedEpisodes;
}

@end
