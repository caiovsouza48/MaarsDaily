#import "DateUtils.h"

@implementation NSDate (DateUtils)

+ (NSDate *)yesterday{
    NSDate *today = [NSDate date];
    return [today dateByAddingTimeInterval: -86400.0];
}

@end