//
//  Date+ComponentValue.swift
//
//
//  Created by lzh on 2021/8/20.
//

import Foundation

public extension Date {
    /// 年
    var year: Int {
        Calendar.current.component(.year, from: self)
    }
    
    /// 月
    var month: Int {
        Calendar.current.component(.month, from: self)
    }
    
    /// 日
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
    
    /// 时
    var hour: Int {
        Calendar.current.component(.hour, from: self)
    }
    
    /// 分
    var minute: Int {
        Calendar.current.component(.minute, from: self)
    }
    
    /// 秒
    var second: Int {
        Calendar.current.component(.second, from: self)
    }

    /// 星期
    var weekday: Int {
        // 1 = 周日，7 = 周六
        Calendar.current.component(.weekday, from: self)
    }
    
    // MARK: - 不常用
    
    /// 纳秒
    var nanosecond: Int {
        Calendar.current.component(.nanosecond, from: self)
    }
    
    /// 本月的第几个星期几
    var weekdayOrdinal: Int {
        Calendar.current.component(.weekdayOrdinal, from: self)
    }
    
    /// 本月的第几周
    var weekOfMonth: Int {
        Calendar.current.component(.weekOfMonth, from: self)
    }
    
    /// 当年的第几周
    var weekOfYear: Int {
        Calendar.current.component(.weekOfYear, from: self)
    }
    
    /// ISO星期年计算的年份
    var yearForWeekOfYear: Int {
        Calendar.current.component(.yearForWeekOfYear, from: self)
    }
    
    /// 季度
    var quarter: Int {
        Calendar.current.component(.quarter, from: self)
    }
}
