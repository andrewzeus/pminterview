//

//

//

//

//  Created by Andrew XU .

//  Copyright (c) 2016. All rights reserved.

//

#import <UIKit/UIKit.h>


@interface LCXExperienceCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *timestampLabel;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLabel;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;


@property (weak, nonatomic) IBOutlet UIView *blurview;

@property (strong, nonatomic) UIImageView *imageImageView;
@property (strong, nonatomic) CAShapeLayer *progressLayer;
//- (void) addTopline:(UIColor *)color;
//@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@end
