#import "ComponentBImpl.h"
#import <ComponentB/ComponentB-Swift.h>

@implementation ComponentBImpl

RegisterBBNCAdapter()

+ (void)helloB {
    [[[ComponentB alloc] init] hello];
}

@end
