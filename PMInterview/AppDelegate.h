//
//  AppDelegate.h
//  PMInterview
//
//  Created by littleorange on 10/31/16.
//  Copyright © 2016 littleorange. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

- (void) shareWithSocialNetwork:(UIImage *)image text:(NSString *)text;
-(BOOL) isInternetReachable;
@end

