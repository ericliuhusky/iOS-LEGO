//
//  ComponentBAPI.m
//  BBMiddlewareAPI
//
//  Created by lzh on 2021/7/14.
//

#import "ComponentBAPI.h"
#import <BBNativeContainer/BBNativeContainer.h>

@implementation ComponentBAPI

+ (Class<ComponentBAPIProtocol>)aigitalVerifyService {
    return [BBNCAdapterHelper adapterServiceProtocol:@protocol(ComponentBAPIProtocol)];
}

+ (void)helloB { 
    [[self aigitalVerifyService] helloB];
}

@end
