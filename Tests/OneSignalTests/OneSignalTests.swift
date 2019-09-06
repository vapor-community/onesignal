@testable import OneSignal
import XCTest

final class OneSignalTests: XCTestCase {
    func testOneSignalNotificationGenerateRequest() throws {
        let apiKey = "YourApiKey"
        let appId = "YourAppId"

        let deviceTokens = ["foo...", "bar..."]
        let message = OneSignalMessage("Hello Vapor!")
        let notif = OneSignalNotification(message: message, users: deviceTokens)
        let app = OneSignalApp(apiKey: apiKey, appId: appId)

        let request = try notif.generateRequest(for: app)

        XCTAssertEqual(request.url.absoluteString, "https://onesignal.com/api/v1/notifications")

        XCTAssertEqual(request.headers["Authorization"].first, "Basic YourApiKey")
        XCTAssertEqual(request.headers["Content-Type"].first, "application/json")

        XCTAssertEqual(request.body?.length, #"{"contents":{"en":"Hello Vapor!"},"app_id":"YourAppId","include_player_ids":["foo...","bar..."]}"# .count)
    }
}
