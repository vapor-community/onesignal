import XCTest
@testable import OneSignal

final class OneSignalTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(OneSignal().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
