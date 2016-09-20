//
//  XFYTVListingDetailsViewController.m
//  XfinityTVListings
//
//  Created by Brendon Lavernia on 9/20/16.
//  Copyright © 2016 Comcast. All rights reserved.
//

#import "XFYTVListingDetailsViewController.h"

@interface XFYTVListingDetailsViewController ()

@end

@implementation XFYTVListingDetailsViewController

- (instancetype) initWithTitle:(NSString *)title
             episodeIdentifier:(NSString *)episodeIdentifier
                   runningTime:(NSString *)runningTime
                episodeSummary:(NSString *)episodeSummary
                         image:(UIImage *)image {
    
    self = [super init];
    
    if (self) {
        _showTitle = title;
        _episodeIdentifier = episodeIdentifier;
        _runningTime = runningTime;
        _episodeSummary = episodeSummary;
        _showArt = image;
        
    }
    return self;
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.showTitleField.text = self.showTitle;
    [self.showTitleField sizeToFit];
    self.episodeIdentifierField.text = self.episodeIdentifier;
    [self.episodeIdentifierField sizeToFit];
    self.runningTimeField.text = self.runningTime;
    [self.runningTimeField sizeToFit];
    self.episodeSummaryField.text = self.episodeSummary;
    [self.episodeSummaryField sizeToFit];
    [self.showArtView setImage:self.showArt];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
