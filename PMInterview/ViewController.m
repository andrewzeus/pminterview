//
//  ViewController.m
//  PMInterview
//
//  Created by littleorange on 10/31/16.
//  Copyright © 2016 littleorange. All rights reserved.
//

#import "ViewController.h"
#import "HttpTool.h"
#import "FeedItem.h"

@interface ViewController ()  <UITableViewDelegate, UITableViewDataSource>

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    self.title = @"Phun App";
    
    [self pullJSONForPW];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (void) pullJSONForPW
{
    self.items = [NSMutableArray array];
    
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
            item.pm_id = feedDict[@"id"];
            item.pm_description = feedDict[@"description"];
            item.title = feedDict[@"title"];
            item.timestamp = feedDict[@"timestamp"];
            item.image = feedDict[@"image"];
            item.date = feedDict[@"date"];
            item.locationline1 = feedDict[@"locationline1"];
            item.locationline2 = feedDict[@"locationline2"];
            
            
            [self.items addObject:item];
        }
        
        
        
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            
            
            
            
            
            
        });
    } failure:^(NSError *error) {
        nil;
    }];
}




@end
