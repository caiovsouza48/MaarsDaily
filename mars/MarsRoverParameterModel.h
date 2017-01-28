#import <Foundation/Foundation.h>

@interface MarsRoverParameterModel : NSObject

@property(nonatomic) NSString *key;

@property(nonatomic) NSString *value;

- (instancetype) initWithKey:(NSString *)key andValue:(NSString *)value;

@end