//
//  XFYTVShowEpisode.h
//  XfinityTVListings
//
//  Created by Brendon Lavernia on 9/20/16.
//  Copyright © 2016 Comcast. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface XFYTVShowEpisode : NSObject

@property (nonatomic, strong, readonly) NSString *network;
@property (nonatomic, strong, readonly) NSString *show;
@property (nonatomic, strong, readonly) NSString *episodeName;
@property (nonatomic, strong, readonly) NSString *season;
@property (nonatomic, strong, readonly) NSString *episodeNumber;
@property (nonatomic, strong, readonly) NSString *episodeSummary;
@property (nonatomic, strong, readonly) NSString *imageURL;
@property (nonatomic, strong, readonly) NSString *minutes;

- (instancetype) initWithNetwork:(NSString *)network
                            show:(NSString *)show
                         episode:(NSString *)episodeName
                          season:(NSString *)season
                   episodeNumber:(NSString *)episodeNumber
                  episodeSummary:(NSString *)episodeSummary
                        imageURL:(NSString *)imageURL
                        duration:(NSString *)minutes;

@end
