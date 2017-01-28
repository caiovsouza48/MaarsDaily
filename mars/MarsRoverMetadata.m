#import "MarsRoverMetadata.h"

@implementation MarsRoverMetadata

- (instancetype) initWithImageURL:(NSString *)imageURL andRoverName:(NSString *)roverName andCameraName:(NSString *)cameraName{
    self = [super init];
    if (self){
        self.imageURL = imageURL;
        self.roverName = roverName;
        self.cameraName = cameraName;
    }
    return self;
}

- (NSUInteger)hash {
    return  self.imageURL.hash ^ self.roverName.hash ^ self.cameraName.hash;
}

- (BOOL)isEqual:(id)object{
    if (self == object) {
        return YES;
    }
    
    if (![object isKindOfClass:[MarsRoverMetadata class]]) {
        return NO;
    }
    
    return [self isEqualToMarsRoverMetadata:(MarsRoverMetadata *)object];
}

- (BOOL)isEqualToMarsRoverMetadata:(MarsRoverMetadata *)object{
    return [self.imageURL isEqualToString:object.imageURL] && [self.roverName isEqualToString:object.roverName];
}

@end