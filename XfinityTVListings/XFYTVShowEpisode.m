//
//  XFYTVShowEpisode.m
//  XfinityTVListings
//
//  Created by Brendon Lavernia on 9/20/16.
//  Copyright © 2016 Comcast. All rights reserved.
//

#import "XFYTVShowEpisode.h"

@implementation XFYTVShowEpisode

- (instancetype) initWithNetwork:(NSString *)network
                            show:(NSString *)show
                         episode:(NSString *)episodeName
                          season:(NSString *)season
                   episodeNumber:(NSString *)episodeNumber
                        imageURL:(NSString *)imageURL
                        duration:(NSString *)minutes {
    
    self = [super init];
    
    if (self) {
        _network = network;
        _show = show;
        _episodeName = episodeName;
        _season = season;
        _episodeNumber = episodeNumber;
        _imageURL = imageURL;
        _minutes = minutes;
    }
    
    return self;
    
}

@end
