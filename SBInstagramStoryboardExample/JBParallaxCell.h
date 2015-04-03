



#import <UIKit/UIKit.h>

@interface JBParallaxCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *parallaxImage;
@property (weak, nonatomic) IBOutlet UILabel *titleLabel;
@property (weak, nonatomic) IBOutlet UILabel *subtitleLabel;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *loadingSpinner;

@property (weak, nonatomic) IBOutlet UILabel *festivallabel;



- (void)cellOnTableView:(UITableView *)tableView didScrollOnView:(UIView *)view;

@end
