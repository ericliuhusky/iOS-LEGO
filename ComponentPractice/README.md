# 组件化实践

## 快速开始

1. `cd ComponentPractice/ComponentDemo`
2. `pod update`
3. 运行输出
```
Hello ComponentA!
Hello ComponentB!
Hello ComponentB!
```

## 目录结构

```
├─ ComponentDemo // 主工程
│  ├─ ComponentDemo
│  │  └─ AppDelegate.swift
│  └─ Podfile
├─ ComponentA // 组件A
├─ ComponentB // 组件B
├─ BBMiddlewareAPI // 中间件
└─ yarn.lock
```

## 组件化Step-by-Step

### 1. 约定协议

```objc
@protocol ComponentAAPIProtocol <NSObject>

+ (void) helloA;
+ (void) useComponentBHello;

@end
```

### 2. 实现接口

```objc
#import "iBBComponentAAPIProtocol.h"

@interface ComponentAAPI : NSObject<ComponentAAPIProtocol>

@end
```

```objc
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
```

### 3. 组件实现

```objc
#import <BBNativeContainer/BBNativeContainer.h>
#import <BBMiddlewareAPI/BBMiddlewareAPI.h>

@interface ComponentAImpl : BBNCAdapterBaseImplement<ComponentAAPIProtocol>

@end
```

```objc
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
```

### 4. 接口调用

```swift
ComponentAAPI.helloA()
ComponentBAPI.helloB()
ComponentAAPI.useComponentBHello()
```
