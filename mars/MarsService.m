#import "MarsService.h"
#import "MarsRoverParameterModel.h"

#define LATEST_MAARS_URL @"http://marsweather.ingenology.com/v1/latest/"

#define MARS_ROVERS_URL @"https://api.nasa.gov/mars-photos/api/v1/rovers/"

#define API_KEY @"pftmFr8wLCPcL1hFXTs1Au8jJGNdt8CXxsnZtwTj"

@implementation MarsService

#pragma mark - Singleton Methods

+ (MarsService *)sharedInstance {
    static MarsService *sharedMarsService = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        sharedMarsService = [[self alloc] initPrivate];
    });
    return sharedMarsService;
}

- (id)initPrivate {
    if (self = [super init]) {
        
    }
    return self;
}

- (id)init{
    @throw [NSException exceptionWithName:NSInternalInconsistencyException
                                   reason:@"init Não é valido para esta classe singleton, use [MarsService sharedIstance]"
                                 userInfo:nil];
    return nil;
}

#pragma mark - Mars Weather API

- (void)getLatestMarsDataWithHandler:(JSONCompletionHandler)handler{
    
    NSURLSession *session = [NSURLSession sharedSession];
    
    [[session dataTaskWithURL:[NSURL URLWithString:LATEST_MAARS_URL]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                NSDictionary *json;
                NSLog(@"Error = %@",[error localizedDescription]);
                if (!error){
                    json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                }
                
                handler(json,error);
                
                
            }] resume];
}

#pragma mark - Mars Rovers API

- (void)getMarsRoversPhotosForParameters:(NSArray *)parametersArray ForRoverCamera:(MarsRoverCamera)camera CompletionHandler:(JSONCompletionHandler)handler{
    NSURLSession *session = [NSURLSession sharedSession];
    NSMutableString *url = [NSMutableString stringWithString:MARS_ROVERS_URL];
    switch (camera) {
        case MarsRoverCuriosity:
            [url appendString:@"curiosity"];
            break;
        case MarsRoverOpportunity:
            [url appendString:@"opportunity"];
            break;
        case MarsRoverSpirit:
            [url appendString:@"spirit"];
            break;
            
        default:
            handler(nil,nil);
            return;
            
    }
    [url appendString:@"/photos?"];
    
    for (MarsRoverParameterModel *parameter in parametersArray) {
        [url appendString:parameter.key];
        [url appendString:@"="];
        [url appendString:parameter.value];
        [url appendString:@"&"];
    }
    
    [url appendString:@"api_key="];
    [url appendString:API_KEY];
    NSLog(@"Mars Rovers Photos Url Formed = %@",url);
    [[session dataTaskWithURL:[NSURL URLWithString:url]
            completionHandler:^(NSData *data,
                                NSURLResponse *response,
                                NSError *error) {
                NSDictionary *json;
                NSLog(@"Error on Mars Rover APi = %@",[error localizedDescription]);
                if (!error){
                    json = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
                }
                
                handler(json,error);
                
                
            }] resume];
}

- (void)getMarsRoversPhotosForAllCamerasWIthParameters:(NSArray *)parametersArray CompletionHandler:(JSONCompletionHandler)handler{
    dispatch_group_t serviceGroup = dispatch_group_create();
    int enumCount = 1;
    NSMutableDictionary *jsonRet = [NSMutableDictionary dictionary];
    while (enumCount < MarsRoverUnknown) {
        dispatch_group_enter(serviceGroup);
        [self getMarsRoversPhotosForParameters:parametersArray ForRoverCamera:enumCount CompletionHandler:^(NSDictionary *json, NSError *error) {
            
            if (!error){
                [jsonRet addEntriesFromDictionary:json];
                dispatch_group_leave(serviceGroup);
                
            }
        }];
        enumCount++;
    }
    
    dispatch_group_notify(serviceGroup,dispatch_get_main_queue(),^{
        handler(jsonRet,nil);
    });
}

@end
