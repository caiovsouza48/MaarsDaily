#import <UIKit/UIKit.h>

@interface ImageVisualizationViewController : UIViewController

@property(nonatomic) UIImage *cellImage;
@property(nonatomic) NSString *roverText;
@property(nonatomic) NSString *cameraText;

@property (weak, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (weak, nonatomic) IBOutlet UILabel *labelCamera;
@property (weak, nonatomic) IBOutlet UILabel *labelRover;

@end