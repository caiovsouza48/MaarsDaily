#import <Foundation/Foundation.h>

@protocol JSONModelProtocol <NSObject>

- (instancetype)initWithJsonData:(NSDictionary *)json;

@end