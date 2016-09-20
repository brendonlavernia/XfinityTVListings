//
//  XFYTVNetwork.m
//  XfinityTVListings
//
//  Created by Brendon Lavernia on 9/20/16.
//  Copyright © 2016 Comcast. All rights reserved.
//

#import "XFYTVNetwork.h"
#import "XFYTVShow.h"
#import "XFYTVShowEpisode.h"

@interface XFYTVNetwork ()

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSMutableDictionary<NSString *, XFYTVShow *> *mutableShows;

@end

@implementation XFYTVNetwork

- (instancetype)initWithName:(NSString *)name {
    self = [super init];
    if (self) {
        _name = name;
        _mutableShows = [[NSMutableDictionary alloc] init];
    }
    return self;
}

- (BOOL)addItemWithTitle:(NSString *)title
             episodeName:(NSString *)episodeName
                  season:(NSString *)season
           episodeNumber:(NSString *)episodeNumber
             description:(NSString *)description
                imageURL:(NSString *)imageURL
                duration:(NSString *)minutes {
    
    XFYTVShow *show;
    
    if ([self.shows objectForKey:title]) {
        show = self.shows[title];
    } else {
        show = [[XFYTVShow alloc] initWithTitle:title network:self.name];
        self.mutableShows[title] = show;
    }
    
    BOOL didOverwriteEpisodeData = [show insertNewEpisode:episodeName
                                                   season:season
                                            episodeNumber:episodeNumber
                                                 imageURL:imageURL
                                                 duration:minutes];
    
    return didOverwriteEpisodeData;
}

- (NSDictionary<NSString *, XFYTVShow *> *) shows {
    return [self.mutableShows copy];
}

- (NSArray *)sortedEpisodes {
    NSArray *sortedShows = [[self.shows allKeys] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
    NSMutableArray<XFYTVShowEpisode *> *sortedEpisodes = [@[] mutableCopy];
    for (NSString *showName in sortedShows) {
        [sortedEpisodes addObjectsFromArray:[self.shows[showName] sortedEpisodes]];
    }
    
    return sortedEpisodes;
}

@end
