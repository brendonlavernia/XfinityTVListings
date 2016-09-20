//
//  XFYTVGoTableViewController.m
//  XfinityTVListings
//
//  Created by Brendon Lavernia on 9/19/16.
//  Copyright © 2016 Comcast. All rights reserved.
//

#import "XFYTVGoTableViewController.h"
#import "XFYTVGoAPI.h"
#import "XFYTVShowEpisode.h"
#import "XFYTVListingDetailsViewController.h"

@interface XFYTVGoTableViewController ()

@property (nonatomic, strong) XFYTVGoAPI *api;
@property (nonatomic, strong) NSMutableDictionary<NSString *, UIImage *> *imageCache;

@end

@implementation XFYTVGoTableViewController


-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    if (!self.imageCache) {
        self.imageCache = [@{} mutableCopy];
        [self.tableView registerClass:[UITableViewCell self] forCellReuseIdentifier:@"XFYTVListingCellReuseIdentifier"];
    }
    
    if (!self.api) {
        self.api = [[XFYTVGoAPI alloc] init];
        [self.api fetchDataForTableView:self.tableView];
    }
    
    NSIndexPath *selectedRow = [self.tableView indexPathForSelectedRow];
    if (selectedRow) {
        [self.tableView deselectRowAtIndexPath:selectedRow animated:YES];
    }
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return [self.api numberOfSections];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.api numberOfRowsForSection:section];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"XFYTVListingCellReuseIdentifier"];
    XFYTVShowEpisode *listing = [self.api episodeListingForIndexPath:indexPath];
    // Configure the cell...
    cell.textLabel.text = listing.show;
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    XFYTVShowEpisode *firstListing = [self.api episodeListingForIndexPath:[NSIndexPath indexPathForRow:0 inSection:section]];
    return firstListing.network;
}


/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    if ([segue.identifier isEqualToString:@"listingDetailSeque"]) {
        XFYTVListingDetailsViewController *ldvc = [segue destinationViewController];
        NSIndexPath *selectedRow = [self.tableView indexPathForSelectedRow];
        XFYTVShowEpisode *listing = [self.api episodeListingForIndexPath:selectedRow];
        UIImage *showArt = [self.imageCache objectForKey:listing.imageURL];
        if (!showArt) {
            showArt = [UIImage imageNamed:@"placeholderArt"];
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0), ^{
                NSURL *url = [[NSURL alloc]initWithString:listing.imageURL];
                NSData *imageData = [NSData dataWithContentsOfURL:url];
                NSData *whiteImage = UIImagePNGRepresentation([UIImage imageNamed:@"whiteImage"]);
                if (![imageData isEqual:whiteImage]) {
                    UIImage *fetchedImage = [UIImage imageWithData:imageData];
                    [self.imageCache setObject:fetchedImage forKey:listing.imageURL];
                    if (ldvc) {
                        ldvc.showArtView.image = fetchedImage;
                    }
                } else {
                     [self.imageCache setObject:[UIImage imageNamed:@"placeholderArt"] forKey:listing.imageURL];
                }
            });
        }
        
        
        ldvc.showTitle = listing.show;
        ldvc.showArt = showArt;
        ldvc.episodeIdentifier = listing.episodeName;
        ldvc.runningTime = [listing.minutes stringByAppendingString:@" min"];
        ldvc.episodeSummary = listing.episodeSummary;
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    [self performSegueWithIdentifier:@"listingDetailSeque" sender:nil];
}


@end
