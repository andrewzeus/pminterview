//
//  FeedItem.h
//  PMInterview
//
//  Created by littleorange on 10/31/16.
//  Copyright © 2016 littleorange. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FeedItem : NSObject <NSCoding>


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

@property (nonatomic , copy) NSString              * pm_id;
@property (nonatomic , copy) NSString              * pm_description;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * timestamp;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * date;
@property (nonatomic , copy) NSString              * locationline1;
@property (nonatomic , copy) NSString              * locationline2;

@end
