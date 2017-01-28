#import "MarsRoverParameterModel.h"

@implementation MarsRoverParameterModel

- (instancetype) initWithKey:(NSString *)key andValue:(NSString *)value{
    self = [super init];
    if (self){
        self.key = key;
        
        self.value = value;
    }
    return self;
}

@end