//

//

//

//

//  Created by Andrew XU .

//  Copyright (c) 2016. All rights reserved.

//
#import "LCXExperienceCell.h"


@interface LCXExperienceCell()

@end


@implementation LCXExperienceCell

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    
    self.descriptionLabel.numberOfLines = 0;
    
    self.blurview.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.8];
    [self.contentView bringSubviewToFront:self.blurview];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.backgroundColor = [UIColor clearColor];
        
        
    }
    return self;
}

- (void)layoutSubviews{
     [super layoutSubviews];
 
     [self.contentView bringSubviewToFront:self.timestampLabel];
     [self.contentView bringSubviewToFront:self.eventNameLabel];
     [self.contentView bringSubviewToFront:self.locationLabel];
     [self.contentView bringSubviewToFront:self.descriptionLabel];
   
}




- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    //[super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


@end
