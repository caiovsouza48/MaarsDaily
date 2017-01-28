#import "MarsReportModel.h"

@implementation MarsReportModel

- (instancetype)initWithJsonData:(NSDictionary *)json{
    self = [super init];
    if (self){
        self.atmoOpacity = [json objectForKey:@"atmo_opacity"];
        self.maxTemp = [[json objectForKey:@"max_temp"] floatValue];
        self.minTemp = [[json objectForKey:@"min_temp"] floatValue];
        self.pressure = [[json objectForKey:@"pressure"] floatValue];
        self.pressureString = [json objectForKey:@"pressure_string"];
        self.season = [json objectForKey:@"season"];
        self.sol = [[json objectForKey:@"sol"] floatValue];
        self.sunset = [json objectForKey:@"sunset"];
        
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        self.terrestrialDate = [dateFormatter dateFromString:[json objectForKey:@"terrestrial_date"]];
    }
    return self;
}

- (NSString *)stringTerrestrialDate{
    NSLog(@"terrestrialDate = %@",self.terrestrialDate);
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    return [dateFormatter stringFromDate:self.terrestrialDate];
}

@end
