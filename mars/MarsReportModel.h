#import <Foundation/Foundation.h>
#import "modelProtocol.h"

@interface MarsReportModel : NSObject<JSONModelProtocol>

@property(nonatomic) NSString *atmoOpacity;

@property(nonatomic) float maxTemp;

@property(nonatomic) float minTemp;

@property(nonatomic) float pressure;

@property(nonatomic) NSString *pressureString;

@property(nonatomic) NSString *season;

@property(nonatomic) float sol;

@property(nonatomic) NSString *sunrise;

@property(nonatomic) NSString *sunset;

@property(nonatomic) NSDate *terrestrialDate;

- (NSString *)stringTerrestrialDate;


@end
