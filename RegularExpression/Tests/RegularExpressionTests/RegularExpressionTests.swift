    import XCTest
    @testable import RegularExpression
    
    let pattern = #"static func [a-z]+[A-Za-z]*"#
    let string = """
        struct RegularExpression {
            static func matches(pattern: String, in string: String) -> [Range<String.Index>] {
                guard let regx = try? NSRegularExpression(pattern: pattern) else { return [] }
                let results = regx.matches(in: string, range: NSMakeRange(0, string.count))
                return results.compactMap { result in
                    return Range(result.range, in: string)
                }
            }

            static func firstMatch(pattern: String, in string: String) -> Range<String.Index>? {
                guard let regx = try? NSRegularExpression(pattern: pattern) else { return nil }
                guard let result = regx.firstMatch(in: string, range: NSMakeRange(0, string.count)) else { return nil }
                return Range(result.range, in: string)
            }


            static func replacedMatches(pattern: String, replacement: String, in string: String) -> String {
                let nsstring = NSMutableString(string: string)
                guard let regx = try? NSRegularExpression(pattern: pattern) else { return string }
                regx.replaceMatches(in: nsstring, range: NSMakeRange(0, string.count), withTemplate: replacement)
                return String(nsstring)
            }
        }
        """

    final class RegularExpressionTests: XCTestCase {
        func testMatches() {
            let results = RegularExpression.matchesString(pattern: pattern, in: string)
            XCTAssertEqual(results, ["static func matches", "static func firstMatch", "static func replacedMatches"])
        }
        
        func testFirstMatch() {
            let result = RegularExpression.firstMatchString(pattern: pattern, in: string)
            XCTAssertEqual(result, "static func matches")
        }
        
        func testReplaceMatches() {
            let result = RegularExpression.replacedMatches(pattern: pattern, replacement: "", in: string)
            XCTAssertNotEqual(result, string)
        }
    }
