//
//  XFYTVListingDetailsViewController.h
//  XfinityTVListings
//
//  Created by Brendon Lavernia on 9/20/16.
//  Copyright © 2016 Comcast. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface XFYTVListingDetailsViewController : UIViewController

@property (strong, nonatomic) UIImage *showArt;
@property (strong, nonatomic) NSString *showTitle;
@property (strong, nonatomic) NSString *episodeIdentifier;
@property (strong, nonatomic) NSString *runningTime;
@property (strong, nonatomic) NSString *episodeSummary;

@property (weak, nonatomic) IBOutlet UIImageView *showArtView;
@property (weak, nonatomic) IBOutlet UILabel *showTitleField;
@property (weak, nonatomic) IBOutlet UILabel *episodeIdentifierField;
@property (weak, nonatomic) IBOutlet UILabel *runningTimeField;

@property (weak, nonatomic) IBOutlet UILabel *episodeSummaryField;

- (instancetype) initWithTitle:(NSString *)title
             episodeIdentifier:(NSString *)episodeIdentifier
                   runningTime:(NSString *)runningTime
                episodeSummary:(NSString *)episodeSummary
                         image:(UIImage *)image;
@end
