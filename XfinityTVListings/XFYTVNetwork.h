//
//  XFYTVNetwork.h
//  XfinityTVListings
//
//  Created by Brendon Lavernia on 9/20/16.
//  Copyright © 2016 Comcast. All rights reserved.
//

@import Foundation;

@class XFYTVShow;
@class XFYTVShowEpisode;

@interface XFYTVNetwork : NSObject

@property (nonatomic, strong, readonly) NSString *name;
@property (nonatomic, strong, readonly) NSDictionary<NSString *, XFYTVShow *>  *shows;

- (instancetype)initWithName:(NSString *)name;
- (BOOL)addItemWithTitle:(NSString *)title
             episodeName:(NSString *)episodeName
                  season:(NSString *)season
           episodeNumber:(NSString *)episodeNumber
             description:(NSString *)description
                imageURL:(NSString *)imageURL
                duration:(NSString *)minutes;
- (NSArray<XFYTVShowEpisode *> *)sortedEpisodes;
@end
