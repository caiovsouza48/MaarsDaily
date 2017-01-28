#import <Foundation/Foundation.h>
#import "modelProtocol.h"

@interface MarsRoverAPIModel : NSObject<JSONModelProtocol>

@property(nonatomic) NSArray *imagesMetadatas;

@end