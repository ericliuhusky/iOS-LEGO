    import XCTest
    @testable import String

    final class StringTests: XCTestCase {
        func testCompare() {
            XCTAssertEqual("2.0".compareVersion("1.1.1"), .orderedDescending)
            XCTAssertEqual("1.0.0".compareVersion("1.0.0"), .orderedSame)
            XCTAssertTrue("apple".caseInsensitiveEqual("APPLE"))
        }
        
        func testEmoji() {
            XCTAssertTrue("😄".first!.isEmoji)
            XCTAssertTrue("🇨🇳".first!.isEmoji)
            XCTAssertTrue("哈😄哈😄哈".containsEmoji)
            XCTAssertEqual("哈😄哈😄哈".removingEmojis, "哈哈哈")
        }
        
        func testIndex() {
            XCTAssertEqual("0123"[0], "0")
            XCTAssertEqual("0123"[0..<3], "012")
            XCTAssertEqual("0123"[0...3], "0123")
            var s = "0123"
            s[0] = "a"
            XCTAssertEqual(s, "a123")
            s[0..<3] = "abc"
            XCTAssertEqual(s, "abc3")
            s[0...3] = "abcd"
            XCTAssertEqual(s, "abcd")
        }
        
        func testNumber() {
            XCTAssertTrue("0123".isAllNumber)
            XCTAssertTrue("0123".isInt)
            XCTAssertFalse("-0123".isAllNumber)
            XCTAssertTrue("-0123".isInt)
        }
        
        func testURL() {
            XCTAssertTrue(["a=1&b=2", "b=2&a=1"].contains(String(parameters: ["a": 1, "b": 2])))
            XCTAssertEqual("a=1&b=2".parameters, ["a": "1", "b": "2"])
            XCTAssertEqual("你好".urlEncoded?.urlDecoded, "你好")
        }
        
        func testCrypto() {
            
        }
        
        func testRegex() {
            
        }
    }
