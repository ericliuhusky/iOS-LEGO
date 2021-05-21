#  OC-Swift-Bridge

Objective-C 和 Swift 的桥接示例

## Usage

1. Swift 访问 OC

```objective-c
// TargetName-Bridging-Header.h

#import "ClassName.h"
```

```swift
class NewClass: ClassName {
// do some override or extension
}
```

2. OC 访问 Swift

```objective-c
#import <TargetName-Swift.h>

// use swift class
```
