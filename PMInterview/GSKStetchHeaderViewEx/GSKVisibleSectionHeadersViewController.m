#import "GSKVisibleSectionHeadersViewController.h"
#import "GSKSpotyLikeHeaderView.h"
#import "UINavigationController+Transparency.h"
#import "UIView+GSKLayoutHelper.h"

#import "Masonry.h"

#import "AppDelegate.h"


#define SCREEN_WIDTH ([[UIScreen mainScreen] bounds].size.width)
#define SCREEN_HEIGHT ([[UIScreen mainScreen] bounds].size.height)
#define SCREEN_MAX_LENGTH (MAX(SCREEN_WIDTH, SCREEN_HEIGHT))
#define SCREEN_MIN_LENGTH (MIN(SCREEN_WIDTH, SCREEN_HEIGHT))


#define APPDELEGATE ((AppDelegate *)[UIApplication sharedApplication].delegate)

@interface GSKVisibleSectionHeadersDataSource : GSKExampleDataSource
@property (nonatomic) CGFloat stretchyHeaderViewMaximumContentHeight;
@property (nonatomic) CGFloat stretchyHeaderViewMinimumContentHeight;
@end

@implementation GSKVisibleSectionHeadersViewController


- (void)shareBtnClicked:(id)sender{
    

    [APPDELEGATE shareWithSocialNetwork:nil text:[NSString stringWithFormat: @"Event: %@. Time: %@. Location: %@,%@. Description: %@.", self.item.title, self.timestampLabel.text, self.item.locationline1, self.item.locationline2, self.item.pm_description]];
    
}

- (void) addFooterView{
    
    UIView *undergroundView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREEN_HEIGHT )];
    undergroundView.backgroundColor = [UIColor whiteColor];
    self.tableView.tableFooterView = undergroundView;
    
    
    
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"yyyy-MM-dd'T'HH:mm:ss.SSS'Z'"];
    NSDate* date = [formatter dateFromString:self.item.date];
    NSDate *someDateInUTC = date;
    NSTimeInterval timeZoneSeconds = [[NSTimeZone localTimeZone] secondsFromGMT];
    NSDate *dateInLocalTimezone = [someDateInUTC dateByAddingTimeInterval:timeZoneSeconds];
    NSString *localDate = [NSDateFormatter localizedStringFromDate:dateInLocalTimezone dateStyle:NSDateFormatterMediumStyle timeStyle:NSDateFormatterMediumStyle];
  
    
     UILabel *timestampLabel = [[UILabel alloc] initWithFrame:CGRectZero];
     timestampLabel.font = [UIFont systemFontOfSize:11];
     timestampLabel.textColor = [UIColor blackColor];
     timestampLabel.textAlignment = NSTextAlignmentLeft;
     [undergroundView addSubview:timestampLabel];
     timestampLabel.text = localDate;
     [timestampLabel mas_makeConstraints:^(MASConstraintMaker *make) {
     make.top.equalTo(undergroundView.mas_top).offset(10);
     make.left.mas_equalTo(10);
     make.width.mas_equalTo(undergroundView.width - 20);
     make.height.mas_equalTo(30);
     }];
     self.timestampLabel = timestampLabel;
    
    
    UILabel *titleLabel = [[UILabel alloc] initWithFrame:CGRectZero];
    titleLabel.font = [UIFont boldSystemFontOfSize:26];
    titleLabel.textColor = [UIColor blackColor];
    titleLabel.textAlignment = NSTextAlignmentLeft;
    titleLabel.numberOfLines = 0;
    [undergroundView addSubview:titleLabel];
    titleLabel.text = self.item.title;
    [titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.timestampLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(undergroundView.width - 20);
        make.height.mas_equalTo(100);
    }];
    self.titleLabel = titleLabel;
    
    
    
    UITextView *textView = [[UITextView alloc] initWithFrame:CGRectZero];
    textView.backgroundColor = [UIColor clearColor];
    [undergroundView addSubview:textView];
    textView.editable = NO;
    textView.dataDetectorTypes = UIDataDetectorTypeLink;
    textView.scrollEnabled = NO;
    textView.delegate = self;
    textView.text = self.item.pm_description;
    [textView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
        make.left.mas_equalTo(10);
        make.width.mas_equalTo(undergroundView.width - 20);
        make.height.mas_equalTo(SCREEN_HEIGHT - 30 - 100);
    }];
    self.descriptionView = textView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //[self.navigationItem setLeftBarButtonItem:[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"back_ICON"] style:UIBarButtonItemStylePlain target:self action:@selector(closeBtnClicked:)] animated:NO];
    
    [self.navigationItem setRightBarButtonItem:[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAction target:self action:@selector(shareBtnClicked:) ]];
    
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    
    self.automaticallyAdjustsScrollViewInsets = NO;
    
    [self addFooterView];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.navigationController gsk_setNavigationBarTransparent:YES animated:NO];
    self.navigationController.navigationBar.barStyle = UIBarStyleBlack;
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
}

- (GSKStretchyHeaderView *)loadStretchyHeaderView {
    return [[GSKSpotyLikeHeaderView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 280) item:self.item];
}

- (GSKExampleDataSource *)loadDataSource {
    GSKVisibleSectionHeadersDataSource *dataSource = [[GSKVisibleSectionHeadersDataSource alloc] init];
    dataSource.stretchyHeaderViewMaximumContentHeight = self.stretchyHeaderView.maximumContentHeight;
    dataSource.stretchyHeaderViewMinimumContentHeight = self.stretchyHeaderView.minimumContentHeight;
    return dataSource;
}

@end

@implementation GSKVisibleSectionHeadersDataSource

- (instancetype)init {
    //return [self initWithNumberOfRows:10];
    return [self initWithNumberOfRows:0];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    //return 10;
    return 0;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    return [NSString stringWithFormat:@"Section #%@", @(section)];
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    UIEdgeInsets scrollViewContentInset = scrollView.contentInset;
    if (scrollView.contentOffset.y > -self.stretchyHeaderViewMinimumContentHeight) {
        scrollViewContentInset.top = self.stretchyHeaderViewMinimumContentHeight;
    } else if (scrollView.contentOffset.y < -self.stretchyHeaderViewMaximumContentHeight) {
        scrollViewContentInset.top = self.stretchyHeaderViewMaximumContentHeight;
    } else {
        scrollViewContentInset.top = -scrollView.contentOffset.y;
    }
    scrollView.contentInset = scrollViewContentInset;
}






- (void) shareWithSocialNetwork:(UIImage *)image data:(NSData *)data url:(NSURL *)url  text:(NSString *)text target:(id)target
{
   
    
    text = text?:@"";
   
    
    
    
    if (!image && data)
    {
        image = [UIImage imageWithData:data];
    }
    
    
    NSMutableArray *activities = [NSMutableArray array];
    
    
    UIActivityViewController *activityController;
    
    if (image)
        activityController = [[UIActivityViewController alloc] initWithActivityItems:@[image,text] applicationActivities:activities];
    else if (url)
        activityController = [[UIActivityViewController alloc] initWithActivityItems:@[url,text] applicationActivities:activities];
    else
        activityController = [[UIActivityViewController alloc] initWithActivityItems:@[data,text] applicationActivities:activities];
    
    
    activityController.excludedActivityTypes = @[UIActivityTypeAssignToContact, UIActivityTypeCopyToPasteboard, UIActivityTypePrint];
    
    
    
    [APPDELEGATE.window.rootViewController presentViewController:activityController animated:YES completion:^{
        
    }];
    
   
}


@end
