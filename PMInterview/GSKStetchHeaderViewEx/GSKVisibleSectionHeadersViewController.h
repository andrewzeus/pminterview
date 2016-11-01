#import "GSKExampleBaseTableViewController.h"
#import "FeedItem.h"

@interface GSKVisibleSectionHeadersViewController : GSKExampleBaseTableViewController
@property (nonatomic, retain) FeedItem *item;


@property (nonatomic, retain) UILabel *timestampLabel;
@property (nonatomic, retain) UILabel *titleLabel;
@property (nonatomic, retain) UITextView *descriptionView;


@end
