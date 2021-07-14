//
//  ComponentAAPI.m
//  BBDefinitionContainer
//
//  Created by lzh on 2021/7/14.
//

#import "ComponentAAPI.h"
#import <BBNativeContainer/BBNativeContainer.h>

@implementation ComponentAAPI

+ (Class<ComponentAAPIProtocol>)aigitalVerifyService {
    return [BBNCAdapterHelper adapterServiceProtocol:@protocol(ComponentAAPIProtocol)];
}

+ (void)helloA {
    [[self aigitalVerifyService] helloA];
}

+ (void)useComponentBHello {
    [[self aigitalVerifyService] useComponentBHello];
}


@end
