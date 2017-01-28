#import "MarsRoverAPIModel.h"
#import "MarsRoverMetadata.h"

@implementation MarsRoverAPIModel

- (instancetype)initWithJsonData:(NSDictionary *)json{
    self = [super init];
    if (self){
        NSArray *photos = [json objectForKey:@"photos"];
        NSMutableArray *imagesMutable = [NSMutableArray array];
        for (id img_src in photos) {
            NSString *imageSource = [img_src objectForKey:@"img_src"];
            NSString *camera = [[img_src objectForKey:@"camera"] objectForKey:@"name"];
            NSString *rover =  [[img_src objectForKey:@"rover"] objectForKey:@"name"];
            [imagesMutable addObject:[[MarsRoverMetadata alloc] initWithImageURL:imageSource andRoverName:rover andCameraName:camera]];
        }
        NSSet *setForImages = [NSSet setWithArray:imagesMutable];
        self.imagesMetadatas = [setForImages allObjects];
    }
    return self;
}

@end