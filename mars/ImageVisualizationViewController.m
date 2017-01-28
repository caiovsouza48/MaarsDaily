#import "ImageVisualizationViewController.h"

@implementation ImageVisualizationViewController

- (void)viewDidLoad{
    [super viewDidLoad];
    self.backgroundImage.image = self.cellImage;
    self.labelCamera.text = _cameraText;
    self.labelRover.text = _roverText;
    [self setupLongPressGestureToImageView];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController setNavigationBarHidden:NO animated:animated];
}

- (void)setupLongPressGestureToImageView{
    [self.backgroundImage setUserInteractionEnabled:YES];
    UILongPressGestureRecognizer *longPress = [[UILongPressGestureRecognizer alloc] initWithTarget:self action:@selector(showImageActionSheet:)];
    [longPress setMinimumPressDuration:0.5];
    
    [self.backgroundImage addGestureRecognizer:longPress];
}

- (void)showImageActionSheet:(id)sender{
    dispatch_async(dispatch_get_main_queue(), ^{
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil message:nil preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleCancel handler:nil];
        
        UIAlertAction *saveToCameraRollAction = [UIAlertAction actionWithTitle:@"Save To Camera Roll" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
            UIImageWriteToSavedPhotosAlbum(self.backgroundImage.image, nil, nil, nil);
        }];
        
        [alertController addAction:saveToCameraRollAction];
        [alertController addAction:cancelAction];
        
        [self presentViewController:alertController animated:YES completion:nil];
    });
}

@end
