#import <UIKit/UIKit.h>
#import "MarsReportModel.h"
#import "MarsRoverAPIModel.h"

@interface FirstViewController : UIViewController

@property(nonatomic) MarsReportModel *model;
@property(nonatomic) MarsRoverAPIModel *roverModel;

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *mainViewActivityIndicator;
@property (weak, nonatomic) IBOutlet UILabel *terrestrialDateLabel;
@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *labelTemperatura;
@property (weak, nonatomic) IBOutlet UILabel *labelAtmosfera;
@property (weak, nonatomic) IBOutlet UICollectionView *imagesCollection;

@end