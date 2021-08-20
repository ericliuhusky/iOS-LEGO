//
//  DateTimeInterval.swift
//  
//
//  Created by lzh on 2021/8/20.
//

/// 日期时间间隔
public enum DateTimeInterval {
    // 几年
    case years(Int)
    // 几月
    case months(Int)
    // 几日
    case days(Int)
    // 几时
    case hours(Int)
    // 几分
    case minutes(Int)
    // 几秒
    case seconds(Int)
    // 几周
    case weeks(Int)
}
