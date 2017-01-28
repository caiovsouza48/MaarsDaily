#import "FirstViewController.h"
#import "MarsService.h"
#import "ImageFX.h"
#import "MarsRoverParameterModel.h"
#import "DateUtils.h"
#import "ImageVisualizationViewController.h"
#import "MarsRoverMetadata.h"

@interface FirstViewController ()

@property(nonatomic) dispatch_semaphore_t semaphore;

@end

@implementation FirstViewController

#pragma mark - UI Methods

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadMarsRecentData];
    [self setNeedsStatusBarAppearanceUpdate];
    //[self loadMarsRoverPhotosForModelEarthDate];
}

- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    //BUGFIX XCode
    [self.tabBarItem setImage:[UIImage imageNamed:@"tabBarRoverIcon.png"]];
    [self.tabBarItem setSelectedImage:[UIImage imageNamed:@"tabBarRoverIcon.png"]];
    
    [self.navigationController setNavigationBarHidden:YES animated:animated];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleLightContent;
}

- (void)updateViewWithModelData{
    dispatch_async(dispatch_get_main_queue(), ^{
        [self loadMarsRoverPhotosForModelEarthDate];
        self.labelTemperatura.text = [NSString stringWithFormat:@"%3.0fº Celsius",_model.maxTemp];
        self.labelAtmosfera.text = [NSString stringWithFormat:@"Atmosphere Opacity is %@ now",_model.atmoOpacity];
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *stringDate = [dateFormatter stringFromDate:_model.terrestrialDate];
        self.terrestrialDateLabel.text = [NSString stringWithFormat:@"Terrestrial Date %@ Report",stringDate];
    });
}

#pragma mark - Network

- (void)downloadImageWithURL:(NSString *)url CompletionHandler:(void (^)(NSData *data))handler{
    dispatch_queue_t imageDownloadQueue = dispatch_queue_create("imageQueue", NULL);
    dispatch_async(imageDownloadQueue, ^{
        NSData *imageData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
        dispatch_async(dispatch_get_main_queue(), ^{
            handler(imageData);
            
        });
    });
}

- (void)loadMarsRecentData{
    [[MarsService sharedInstance] getLatestMarsDataWithHandler:^(NSDictionary *json,NSError *error) {
        if (!error){
            NSLog(@"JSON = %@",json);
            NSDictionary *reportDataUnwrapped = [json objectForKey:@"report"];
            self.model = [[MarsReportModel alloc] initWithJsonData:reportDataUnwrapped];
            if (self.model.terrestrialDate == nil){
                self.model.terrestrialDate = [NSDate yesterday];
            }
            [self updateViewWithModelData];
        }
    }];
}

- (void)loadMarsRoverPhotosForModelEarthDate{
    MarsRoverParameterModel *parameter = [[MarsRoverParameterModel alloc] initWithKey:@"earth_date" andValue:[self.model stringTerrestrialDate]];
    
    [[MarsService sharedInstance] getMarsRoversPhotosForAllCamerasWIthParameters:@[parameter] CompletionHandler:^(NSDictionary *json, NSError *error) {
        self.roverModel = [[MarsRoverAPIModel alloc] initWithJsonData:json];
        NSString *urlAsString = ((MarsRoverMetadata *)self.roverModel.imagesMetadatas[0]).imageURL;
        [self downloadImageWithURL:urlAsString CompletionHandler:^(NSData *data) {
            //self.backgroundImage.image = [[UIImage imageWithData:data] applyDarkEffect];
            self.backgroundImage.image = [[UIImage imageNamed:@"mars.jpg"] applyDarkEffect];
            [self.mainViewActivityIndicator stopAnimating];
            [self.imagesCollection reloadData];
        }];
    }];
}

#pragma mark - Segue
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Make sure your segue name in storyboard is the same as this line
    if ([[segue identifier] isEqualToString:@"showImageSegueIdentifier"])
    {
        if ([sender isKindOfClass:[UICollectionViewCell class]]){
            UICollectionViewCell *senderCell = (UICollectionViewCell *)sender;
            NSIndexPath *indexPath = [self.imagesCollection indexPathForCell:senderCell];
            MarsRoverMetadata *metadata = (MarsRoverMetadata *)self.roverModel.imagesMetadatas[indexPath.item];
            // Get reference to the destination view controller
            ImageVisualizationViewController *imageVC = [segue destinationViewController];
            imageVC.roverText = metadata.roverName;
            imageVC.cellImage = ((UIImageView *)senderCell.backgroundView).image;
            imageVC.cameraText = metadata.cameraName;
        }
    }
}

#pragma mark - Collection View Data Source

- (NSInteger)collectionView:(UICollectionView*)collectionView numberOfItemsInSection:(NSInteger)section {
    return self.roverModel.imagesMetadatas.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView
                  cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cellIdentifier" forIndexPath:indexPath];
    
    NSString *urlAsString = ((MarsRoverMetadata *)self.roverModel.imagesMetadatas[indexPath.item]).imageURL;

    [self downloadImageWithURL:urlAsString CompletionHandler:^(NSData *data) {
        
        
        ((UIImageView *)cell.backgroundView).image = [UIImage imageWithData:data];
        
        
    }];
    return cell;
}

#pragma mark - Background Tasks

- (void)doBackgroundTask{
    
}

@end
