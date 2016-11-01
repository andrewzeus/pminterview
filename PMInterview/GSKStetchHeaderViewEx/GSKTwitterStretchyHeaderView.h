#import <GSKStretchyHeaderView/GSKStretchyHeaderView.h>

@protocol  GSKTwitterStretchyHeaderViewDelegate;
@class DZNSegmentedControl;

@interface GSKTwitterStretchyHeaderView : GSKStretchyHeaderView

@property (weak, nonatomic) id<GSKTwitterStretchyHeaderViewDelegate> delegate;
@property (nonatomic) UIImageView *userImageView;
@property (nonatomic) UILabel *navigationBarTitle;

@property (nonatomic) DZNSegmentedControl *topSegmentedControl;
@property (nonatomic) DZNSegmentedControl *tabs;

@property (nonatomic) UILabel *navigationSubtitleLabel;

@end

@protocol GSKTwitterStretchyHeaderViewDelegate <NSObject>

- (void)headerView:(GSKTwitterStretchyHeaderView *)headerView
  didTapBackButton:(id)sender;

- (void)headerView:(GSKTwitterStretchyHeaderView *)headerView
  didTapSettingButton:(id)sender;

@end

