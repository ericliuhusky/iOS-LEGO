import Foundation

public struct RegularExpression {
    public static func matches(pattern: String, in string: String) -> [Range<String.Index>] {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return [] }
        let results = regex.matches(in: string, range: NSMakeRange(0, string.count))
        return results.compactMap { result in
            return Range(result.range, in: string)
        }
    }
    
    public static func firstMatch(pattern: String, in string: String) -> Range<String.Index>? {
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return nil }
        guard let result = regex.firstMatch(in: string, range: NSMakeRange(0, string.count)) else { return nil }
        return Range(result.range, in: string)
    }


    public static func replacedMatches(pattern: String, replacement: String, in string: String) -> String {
        let nsstring = NSMutableString(string: string)
        guard let regex = try? NSRegularExpression(pattern: pattern) else { return string }
        regex.replaceMatches(in: nsstring, range: NSMakeRange(0, string.count), withTemplate: replacement)
        return String(nsstring)
    }
}

extension RegularExpression {
    public static func matchesString(pattern: String, in string: String) -> [String] {
        return matches(pattern: pattern, in: string).map { range in
            return String(string[range])
        }
    }
    
    public static func firstMatchString(pattern: String, in string: String) -> String? {
        guard let range = firstMatch(pattern: pattern, in: string) else { return nil }
        return String(string[range])
    }
}
