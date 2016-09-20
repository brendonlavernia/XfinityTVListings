//
//  XFYTVGoAPI.h
//  XfinityTVListings
//
//  Created by Brendon Lavernia on 9/19/16.
//  Copyright © 2016 Comcast. All rights reserved.
//

@import Foundation;
@import UIKit;
@class XFYTVShowEpisode;

extern NSString * const XFYTVGoAPIURL;

@interface XFYTVGoAPI : NSObject

- (instancetype)init;
- (void)fetchDataForTableView:(UITableView *) tv;
- (XFYTVShowEpisode *)episodeListingForIndexPath:(NSIndexPath *)indexPath;
- (NSInteger)numberOfSections;
- (NSInteger)numberOfRowsForSection:(NSInteger)section;

@end
