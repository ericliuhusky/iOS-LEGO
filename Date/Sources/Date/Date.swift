import Foundation

public extension Date {
    var year: Int {
        Calendar.current.component(.year, from: self)
    }
    
    var month: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var day: Int {
        Calendar.current.component(.day, from: self)
    }
    
    var hour: Int {
        Calendar.current.component(.hour, from: self)
    }
    
    var minute: Int {
        Calendar.current.component(.minute, from: self)
    }
    
    var second: Int {
        Calendar.current.component(.second, from: self)
    }

    // 1 = 周日，7 = 周六
    var weekday: Int {
        Calendar.current.component(.weekday, from: self)
    }
}


public extension Date {
    enum DateTimeInterval {
        case years(Int)
        case months(Int)
        case days(Int)
        case hours(Int)
        case minutes(Int)
        case seconds(Int)
    }
    
    func adding(time: DateTimeInterval) -> Date {
        switch time {
        case let .years(years):
            return Calendar.current.date(byAdding: .year, value: years, to: self) ?? self
        case let .months(months):
            return Calendar.current.date(byAdding: .month, value: months, to: self) ?? self
        case let .days(days):
            return Calendar.current.date(byAdding: .day, value: days, to: self) ?? self
        case let .hours(hours):
            return Calendar.current.date(byAdding: .hour, value: hours, to: self) ?? self
        case let .minutes(minutes):
            return Calendar.current.date(byAdding: .minute, value: minutes, to: self) ?? self
        case let .seconds(seconds):
            return Calendar.current.date(byAdding: .second, value: seconds, to: self) ?? self
        }
    }
}


public extension Date {
    init?(date: String, format: String) {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        guard let date = formatter.date(from: date) else { return nil }
        self = date
    }
    
    func string(format: String) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = format
        return formatter.string(from: self)
    }
}
