//
//  Rivar.swift
//  
//
//  Created by lzh on 2021/5/18.
//

import ObjectiveC

/// 封装实例变量描述
public struct Rivar {
    var ivar: Ivar?
    
    init(_ ivar: Ivar?) {
        self.ivar = ivar
    }
    
    /// 名称
    public func getName() -> String {
        guard let ivar = self.ivar else { return "" }
        guard let ivarName = ivar_getName(ivar) else { return "" }
        return String(cString: ivarName)
    }
    
    // TODO: getTypeEncoding, getOffset
}
