import Foundation

extension Date {
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

enum DateTimeInterval {
    case years(Int)
    case months(Int)
    case days(Int)
    case hours(Int)
    case minutes(Int)
    case seconds(Int)
}


extension Date {
    func adding(time: DateTimeInterval) -> Date {
        switch time {
        case let .years(years):
            return adding(time: .months(years * 12))
        case let .months(months):
            return adding(time: .days(months * 30))
        case let .days(days):
            return adding(time: .hours(days * 24))
        case let .hours(hours):
            return adding(time: .minutes(hours * 60))
        case let .minutes(minutes):
            return adding(time: .seconds(minutes * 60))
        case let .seconds(seconds):
            return addingTimeInterval(Double(seconds))
        }
    }
}



