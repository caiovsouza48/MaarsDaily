#import <Foundation/Foundation.h>

@interface MarsService : NSObject

typedef void (^JSONCompletionHandler)(NSDictionary *, NSError *);

typedef NS_ENUM(NSInteger, MarsRoverCamera) {
    MarsRoverCuriosity = 1,
    MarsRoverOpportunity,
    MarsRoverSpirit,
    MarsRoverUnknown
    
};

+ (MarsService *)sharedInstance;

- (void)getLatestMarsDataWithHandler:(JSONCompletionHandler)handler;

- (void)getMarsRoversPhotosForParameters:(NSArray *)parametersArray ForRoverCamera:(MarsRoverCamera)camera CompletionHandler:(JSONCompletionHandler)handler;

- (void)getMarsRoversPhotosForAllCamerasWIthParameters:(NSArray *)parametersArray CompletionHandler:(JSONCompletionHandler)handler;

@end
