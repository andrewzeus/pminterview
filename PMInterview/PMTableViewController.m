//
//  PMTableViewController.m
//  PMInterview
//
//  Created by littleorange on 10/31/16.
//  Copyright © 2016 littleorange. All rights reserved.
//

#import "PMTableViewController.h"
#import "GSKVisibleSectionHeadersViewController.h"
#import "RealReachability.h"
#import "AppDelegate.h"
//#import "Reachability.h"
#import <SystemConfiguration/SystemConfiguration.h>

#import "HttpTool.h"
#import "FeedItem.h"
#import "LCXExperienceCell.h"
#import "Masonry.h"

#import <SDWebImage/UIImageView+WebCache.h>
#import "UIImage+ImageWithColor.h"


#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))

#define lcxcellIdentifier @"lcxexperienceCell"

@interface PMTableViewController ()

@end

@implementation PMTableViewController

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    //[self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleDefault;
    self.navigationController.navigationBar.tintColor = [UIColor blackColor];
    
    self.title = @"Phun App";
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.title = @"Phun App";
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    [self.tableView registerNib:[UINib nibWithNibName:@"LCXExperienceCell" bundle:nil] forCellReuseIdentifier:lcxcellIdentifier];
    
    [self loadData];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - TableViewDelegate和TableViewDataSource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return self.items.count;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return 1;
}







- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    CGFloat rowHeight = 170.f;
    
    
    return rowHeight;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    LCXExperienceCell* cell = [tableView dequeueReusableCellWithIdentifier:lcxcellIdentifier];
    
    cell.imageImageView.contentMode = UIViewContentModeScaleAspectFill;
    cell.imageImageView.clipsToBounds = YES;
    
    FeedItem *item = self.items[indexPath.row];
    if (item && item.timestamp && item.timestamp.length)
    {
        
        NSString *dateStr = item.date;
        
        
        NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
        NSDate* date = [formatter dateFromString:dateStr];
        NSDate *someDateInUTC = date;
        NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
        NSDate *dateInLocalTimezone = [someDateInUTC dateByAddingTimeInterval:timeZoneSeconds];
        NSString *localDate = [NSDateFormatter localizedStringFromDate:dateInLocalTimezone dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
        
        
        
        cell.timestampLabel.text = localDate;
    }
    
    if (item && item.title && item.title.length)
    {
        cell.eventNameLabel.text = item.title;
    }
    
    if (item && item.locationline1 && item.locationline2)
    {
        cell.locationLabel.text = [NSString stringWithFormat:@"%@ %@", item.locationline1, item.locationline2];
    }
    
    if (item && item.pm_description && item.pm_description.length)
    {
        cell.descriptionLabel.text = item.pm_description;
    }
    
    
    if (item && item.image && item.image.length){
        [cell.imageImageView sd_setImageWithURL:[NSURL URLWithString:item.image] placeholderImage:[UIImage imageNamed:@"placeholder"]];
    }
    else{
        [cell.imageImageView setImage:[UIImage imageNamed:@"placeholder"]];
    }
    


    return cell;
    
    
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    self.title = @"";
    
    //LCXExperienceCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    //[cell.contentView bringSubviewToFront:cell.blurview];
    

    FeedItem *item = self.items[indexPath.row];
    
    GSKVisibleSectionHeadersViewController *vc = [GSKVisibleSectionHeadersViewController new];
    vc.item = item;
    [self.navigationController pushViewController:vc animated:YES];
    
}





- (void) loadData
{
    self.items = [NSMutableArray array];
    
    
    if (APPDELEGATE.isInternetReachable){
        
    }
    else{
        
        [self.items removeAllObjects];
        
        NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [currentDefaults objectForKey:@"tableViewDataArray"];
        NSArray * retrievedItems = [NSKeyedUnarchiver unarchiveObjectWithData:data];
        [self.items addObjectsFromArray:retrievedItems];
        
        
        if (retrievedItems){
            [self.tableView reloadData];
            return;
        }
        else{
            [self.items removeAllObjects];
        }
    }
    
    NSString *pwAPIURL = @"https://raw.githubusercontent.com/phunware/dev-interview-homework/master/feed.json";
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    [HttpTool get:pwAPIURL parameters:params success:^(id json) {
        
        dispatch_async(dispatch_get_main_queue(), ^{
            //[hud hide:YES];
        });
        
        NSArray *jsonArr = (NSArray *)json;
        NSLog (@"%@", jsonArr);
        
        for (int i = 0; i < jsonArr.count; i++)
        {
            NSDictionary *feedDict = (NSDictionary *)jsonArr[i];
            
            /*
             {
             "id": 1,
             "description": "Rebel Forces spotted on Hoth. Quell their rebellion for the Empire.",
             "title": "Stop Rebel Forces",
             "timestamp": "2015-06-18T17:02:02.614Z",
             "image": "https://raw.githubusercontent.com/phunware/services-interview-resources/master/images/Battle_of_Hoth.jpg",
             "date": "2015-06-18T23:30:00.000Z",
             "locationline1": "Hoth",
             "locationline2": "Anoat System"
             },
             */
            
            
            FeedItem *item = [[FeedItem alloc] init];
            item.pm_id = ![feedDict[@"id"] isKindOfClass:[NSNull class]]?feedDict[@"id"] :@"";
            item.pm_description = ![feedDict[@"description"] isKindOfClass:[NSNull class]]?feedDict[@"description"] :@"";
            item.title = ![feedDict[@"title"] isKindOfClass:[NSNull class]]?feedDict[@"title"] :@"";
            item.timestamp = ![feedDict[@"timestamp"] isKindOfClass:[NSNull class]]?feedDict[@"timestamp"] :@"";
            item.image = ![feedDict[@"image"] isKindOfClass:[NSNull class]]?feedDict[@"image"] :@"";
            item.date = ![feedDict[@"date"] isKindOfClass:[NSNull class]]?feedDict[@"date"] :@"";
            item.locationline1 = ![feedDict[@"locationline1"] isKindOfClass:[NSNull class]]?feedDict[@"locationline1"] :@"";
            item.locationline2 = ![feedDict[@"locationline2"] isKindOfClass:[NSNull class]]?feedDict[@"locationline2"] :@"";
            
            
            [self.items addObject:item];
        }
        
        NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
        NSData *data = [NSKeyedArchiver archivedDataWithRootObject:self.items];
        [currentDefaults setObject:data forKey:@"tableViewDataArray"];
        [currentDefaults synchronize];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            [self.tableView reloadData];
            
            
            
            
        });
    } failure:^(NSError *error) {
        
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            [self.items removeAllObjects];
            
            NSUserDefaults *currentDefaults = [NSUserDefaults standardUserDefaults];
            NSData *data = [currentDefaults objectForKey:@"tableViewDataArray"];
            NSArray * retrievedItems = [NSKeyedUnarchiver unarchiveObjectWithData:data];
            [self.items addObjectsFromArray:retrievedItems];
            
            [self.tableView reloadData];
            
            
            
            
        });
    }];
}




@end
