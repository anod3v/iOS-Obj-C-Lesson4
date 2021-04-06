//
//  LocationManager.h
//  TestApp
//
//  Created by Andrey on 18/03/2021.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

typedef void(^LocationCallback)(CLLocation *location);

@interface LocationManager : NSObject

@property (nonatomic, weak) CLLocation *currentLocation;
@property (nonatomic, copy) LocationCallback locationCallback;

- (void)start;
- (void)stop;

@end
