//
//  Date+Extensions.swift
//  
//
//  Created by lzh on 2021/8/20.
//

import Foundation

public extension Date {    
    /// 判断闰月
    var isLeapMonth: Bool {
        Calendar.current.dateComponents([.quarter], from: self).isLeapMonth ?? false
    }
    
    /// 判断闰年
    var isLeapYear: Bool {
        (year % 100 != 0 && year % 4 == 0) || (year % 400 == 0)
    }
    
    /// 判断是今天
    var isToday: Bool {
        day == Date().day
    }
    
    /// 判断是昨天
    var isYesterday: Bool {
        day == Date().adding(.days(-1)).day
    }
    
    /// 判断是前天
    var isDayBeforeYesterday: Bool {
        day == Date().adding(.days(-2)).day
    }
    
    /// 年初
    var startOfYear: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year], from: self)) ?? self
    }
    
    /// 年末
    var endOfYear: Date {
        // 明年前一秒
        startOfYear.adding(.years(1)).adding(.seconds(-1))
    }
    
    /// 月初
    var startOfMonth: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month], from: self)) ?? self
    }
    
    /// 月末
    var endOfMonth: Date {
        // 下个月前一秒
        startOfMonth.adding(.months(1)).adding(.seconds(-1))
    }
    
    /// 一天的开始
    var startOfDay: Date {
        Calendar.current.date(from: Calendar.current.dateComponents([.year, .month, .day], from: self)) ?? self
    }
    
    /// 一天的结束
    var endOfDay: Date {
        // 明天前一秒
        startOfDay.adding(.days(1)).adding(.seconds(-1))
    }
    
    /// 每星期第一天，周日
    var startOfWeek: Date {
        startOfDay.adding(.days(-(weekday - 1)))
    }
    
    /// 每星期最后一天
    var endOfWeek: Date {
        // 下星期前一秒
        startOfWeek.adding(.weeks(1)).adding(.seconds(-1))
    }
    
    
    /// 当前日期添加日期时间间隔之后的日期
    /// - Parameter time: 日期时间间隔
    /// - Returns: 添加后的新日期
    func adding(_ time: DateTimeInterval) -> Date {
        switch time {
        case .years(let years):
            return Calendar.current.date(byAdding: .year, value: years, to: self) ?? self
        case .months(let months):
            return Calendar.current.date(byAdding: .month, value: months, to: self) ?? self
        case .days(let days):
            return Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
        case .hours(let hours):
            return Calendar.current.date(byAdding: .hour, value: hours, to: self) ?? self
        case .minutes(let minutes):
            return Calendar.current.date(byAdding: .minute, value: minutes, to: self) ?? self
        case .seconds(let seconds):
            return Calendar.current.date(byAdding: .second, value: seconds, to: self) ?? self
        case .weeks(let weeks):
            return Calendar.current.date(byAdding: .day, value: weeks * 7, to: self) ?? self
        }
    }
    
    /// 使用格式化的日期字符串和对应的日期格式化控制字符构造日期
    /// - Parameters:
    ///   - date: 格式化的日期字符串
    ///   - format: 日期格式化控制字符
    ///   - timeZone: 时区，默认为nil
    ///   - locale: 地区，默认为nil
    init?(date: String, format: String, timeZone: TimeZone? = nil, locale: Locale? = nil) {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let timeZone = timeZone {
            formatter.timeZone = timeZone
        }
        if let locale = locale {
            formatter.locale = locale
        }
        guard let date = formatter.date(from: date) else { return nil }
        self = date
    }
    
    /// 使用日期格式化控制字符格式化日期
    /// - Parameters:
    ///   - format: 日期格式化控制字符
    ///   - timeZone: 时区，默认为nil
    ///   - locale: 地区，默认为nil
    /// - Returns: 格式化后的日期字符串
    func string(format: String, timeZone: TimeZone? = nil, locale: Locale? = nil) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        if let timeZone = timeZone {
            formatter.timeZone = timeZone
        }
        if let locale = locale {
            formatter.locale = locale
        }
        return formatter.string(from: self)
    }
}
