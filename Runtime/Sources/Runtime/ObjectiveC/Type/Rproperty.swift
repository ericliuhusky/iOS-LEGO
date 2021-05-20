//
//  Rproperty.swift
//  
//
//  Created by lzh on 2021/5/18.
//

import ObjectiveC

/// 封装属性
public struct Rproperty {
    var property: objc_property_t?
    
    init(_ property: objc_property_t?) {
        self.property = property
    }
    
    /// 名称
    public func getName() -> String {
        guard let property = self.property else { return "" }
        let propertyName = property_getName(property)
        return String(cString: propertyName)
    }
    
    // TODO: getAttributes, copyAttributeValue, copyAttributeList
}
