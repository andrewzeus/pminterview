//
//  FeedItem.m
//  PMInterview
//
//  Created by littleorange on 10/31/16.
//  Copyright © 2016 littleorange. All rights reserved.
//

#import "FeedItem.h"

@implementation FeedItem 


/*
 
 
 
@property (nonatomic , copy) NSString              * pm_id;
@property (nonatomic , copy) NSString              * pm_description;
@property (nonatomic , copy) NSString              * title;
@property (nonatomic , copy) NSString              * timestamp;
@property (nonatomic , copy) NSString              * image;
@property (nonatomic , copy) NSString              * date;
@property (nonatomic , copy) NSString              * locationline1;
@property (nonatomic , copy) NSString              * locationline2;
*/


- (void)encodeWithCoder:(NSCoder *)coder {
    [coder encodeObject:self.pm_id forKey:@"id"];
    [coder encodeObject:self.pm_description forKey:@"description"];
    
    [coder encodeObject:self.title forKey:@"title"];
    [coder encodeObject:self.timestamp forKey:@"timestamp"];
    
    [coder encodeObject:self.image forKey:@"image"];
    [coder encodeObject:self.date forKey:@"date"];
    
    [coder encodeObject:self.locationline1 forKey:@"locationline1"];
    [coder encodeObject:self.locationline2 forKey:@"locationline2"];
}

- (id)initWithCoder:(NSCoder *)coder {
    self = [super init];
    if (self) {
        self.pm_id = [coder decodeObjectForKey:@"id"];
        self.pm_description = [coder decodeObjectForKey:@"description"];
        
        self.title = [coder decodeObjectForKey:@"title"];
        self.timestamp = [coder decodeObjectForKey:@"timestamp"];
        
        
        self.image = [coder decodeObjectForKey:@"image"];
        self.date = [coder decodeObjectForKey:@"date"];
        
        self.locationline1 = [coder decodeObjectForKey:@"locationline1"];
        self.locationline2 = [coder decodeObjectForKey:@"locationline2"];
    }
    return self;
}


@end
