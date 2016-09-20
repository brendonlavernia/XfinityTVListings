//
//  XFYTVShow.h
//  XfinityTVListings
//
//  Created by Brendon Lavernia on 9/20/16.
//  Copyright © 2016 Comcast. All rights reserved.
//

@import Foundation;
@class XFYTVShowEpisode;

@interface XFYTVShow : NSObject

@property (nonatomic, strong, readonly) NSString *title;
@property (nonatomic, strong, readonly) NSString *network;
@property (nonatomic, strong, readonly) NSDictionary<NSString *, XFYTVShowEpisode *> *episodes;

- (instancetype) initWithTitle:(NSString *)title network:(NSString *)network;
- (BOOL) insertNewEpisode:(NSString *)episodeName
                   season:(NSString *)season
            episodeNumber:(NSString *)episodeNumber
           episodeSummary:(NSString *)episodeSummary
                 imageURL:(NSString *)imageURL
                 duration:(NSString *)minutes;
- (NSArray<XFYTVShowEpisode *> *) sortedEpisodes;

@end
