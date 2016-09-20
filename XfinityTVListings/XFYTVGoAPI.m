//
//  XFYTVGoAPI.m
//  XfinityTVListings
//
//  Created by Brendon Lavernia on 9/19/16.
//  Copyright © 2016 Comcast. All rights reserved.
//

#import "XFYTVGoAPI.h"
#import "XFYTVNetwork.h"

NSString * const XFYTVGoAPIURL = @"http://tvgo.xfinity.com/api/xfinity/ipad/home/videos?filter&type=json";

@interface XFYTVGoAPI ()

@property (nonatomic, strong) NSMutableDictionary<NSString *, XFYTVNetwork *> *networks;
@property (nonatomic, strong) NSMutableArray<NSArray<XFYTVShowEpisode *> *> *cells;

@end

@implementation XFYTVGoAPI

- (instancetype) init {
    self = [super init];
    
    if (self) {
        _networks = [@{} mutableCopy];
        _cells = [@[] mutableCopy];
    }
    
    return self;
}

- (void)fetchDataForTableView:(UITableView *) tv {
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:XFYTVGoAPIURL]];
    __block NSDictionary *json;
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse * _Nullable response, NSData * _Nullable data, NSError * _Nullable connectionError) {
        json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
        
        NSDictionary<NSString *, NSString*> *networkMap = json[@"providerCodesMap"];
        for (NSString *network in [networkMap allValues]) {
            self.networks[network] = [[XFYTVNetwork alloc] initWithName:network];
        }
        
        NSArray *jsonItems = json[@"videoGalleries"];
        for (NSDictionary *dailyListings in jsonItems) {
            if ([dailyListings objectForKey:@"items"]) {
                NSArray *listings = dailyListings[@"items"];
                for (NSDictionary *listing in listings) {
                    NSString *networkName = networkMap[listing[@"videoProviderCode"]];
                    NSString *show = listing[@"name"];
                    NSString *episode = listing[@"episodeName"];
                    NSString *season = listing[@"episodeSeasonNumber"];
                    NSString *episodeNumber = listing[@"episodeNumber"];
                    NSString *episodeSummary = listing[@"videoDescription"];
                    NSString *imageURL = ((NSDictionary *)listing[@"image"])[@"src"];
                    NSString *duration = [[NSNumber numberWithInt:ceil([listing[@"videoDuration"] integerValue] / 60.0)] stringValue];
                    XFYTVNetwork *network = self.networks[networkName];
                    [network addItemWithTitle:show episodeName:episode season:season episodeNumber:episodeNumber
                                  description:episodeSummary imageURL:imageURL duration:duration];
                }
            }
        }
        NSArray *sortedNetworks = [[networkMap allValues] sortedArrayUsingSelector:@selector(caseInsensitiveCompare:)];
        for (NSString *networkName in sortedNetworks) {
            [self.cells addObject:[self.networks[networkName] sortedEpisodes]];
        }
        
        dispatch_async(dispatch_get_main_queue(), ^{
            [tv reloadData];
        });
        
    }];

}

- (XFYTVShowEpisode *)episodeListingForIndexPath:(NSIndexPath *)indexPath {
    return self.cells[indexPath.section][indexPath.row];
}
        
- (NSInteger)numberOfSections {
    return self.cells.count;
}


- (NSInteger)numberOfRowsForSection:(NSInteger)section {
    return self.cells[section].count;
}



@end
