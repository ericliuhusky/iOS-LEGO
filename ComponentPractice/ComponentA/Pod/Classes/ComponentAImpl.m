#import "ComponentAImpl.h"
#import <ComponentA/ComponentA-Swift.h>

@implementation ComponentAImpl

RegisterBBNCAdapter()

+ (void)helloA {
    [[[ComponentA alloc] init] hello];
}

+ (void)useComponentBHello {
    [[[ComponentA alloc] init] useComponentBHello];
}

@end
