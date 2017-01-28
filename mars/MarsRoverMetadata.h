#import <Foundation/Foundation.h>

@interface MarsRoverMetadata : NSObject

@property(nonatomic) NSString *imageURL;

@property(nonatomic) NSString *roverName;

@property(nonatomic) NSString *cameraName;

- (instancetype) initWithImageURL:(NSString *)imageURL andRoverName:(NSString *)roverName andCameraName:(NSString *)cameraName;

- (BOOL)isEqualToMarsRoverMetadata:(MarsRoverMetadata *)object;

@end