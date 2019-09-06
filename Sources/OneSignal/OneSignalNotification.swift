//
//  OneSignalNotification.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//

import AsyncHTTPClient
import Foundation

public struct OneSignalNotification: Codable {
    enum CodingKeys: String, CodingKey {
        case users
        case deviceTokens

        case title
        case subtitle
        case message

        case category = "ios_category"

        case sound = "ios_sound"
        case sendAfter = "send_after"
        case additionalData = "data"
        case attachments = "ios_attachments"

        case isContentAvailable = "content_available"
        case isContentMutable = "mutable_content"
    }

    /**
     RECOMMENDED - Specific players to send your notification to. Does not require API Auth Key.
     Do not combine with other targeting parameters. Not compatible with any other targeting parameters.

     Example: `["1dd608f2-c6a1-11e3-851d-000c2940e62c"]`
     */
    public var users: [String] = []

    /**
     NOT RECOMMENDED - Please consider using include_player_ids instead.
     Target using iOS device tokens. Warning: Only works with Production tokens.
     All non-alphanumeric characters must be removed from each token. If a token does not correspond
     to an existing user, a new user will be created.

     Example: `ce777617da7f548fe7a9ab6febb56cf39fba6d38203...`
     */
    public var deviceTokens: [String]?

    /**
     The notification's title, a map of language codes to text for each language. Each hash must have a language
     code string for a key, mapped to the localized text you would like users to receive for that language.
     This field supports inline substitutions.

     Example: `{"en": "English Title", "es": "Spanish Title"}`
     */
    public var title: OneSignalMessage?

    /**
     The notification's subtitle, a map of language codes to text for each language.
     Each hash must have a language code string for a key, mapped to the localized text you would like
     users to receive for that language.

     This field supports inline substitutions https://documentation.onesignal.com/docs/tag-variable-substitution.
     */
    public var subtitle: OneSignalMessage?

    /**
     REQUIRED unless content_available=true or template_id is set.

     The notification's content (excluding the title), a map of language codes to text for each language.

     Each hash must have a language code string for a key, mapped to the localized text you would like
     users to receive for that language.
     This field supports inline substitutions.
     English must be included in the hash.

     Example: `{"en": "English Message", "es": "Spanish Message"}`
     */
    public var message: OneSignalMessage

    /**
     Category APS payload, use with `registerUserNotificationSettings:categories` in your Objective-C / Swift code.

     Example: calendar category which contains actions like accept and decline
     iOS 10+ This will trigger your `UNNotificationContentExtension` whose ID matches this category.
     */
    public var category: String?

    /**
     Sound file that is included in your app to play instead of the default device notification sound.
     Pass nil to disable vibration and sound for the notification.

     Example: `"notification.wav"`
     */
    public var sound: String?

    /**
     Schedule notification for future delivery.

     Examples: All examples are the exact same date & time.
     `"Thu Sep 24 2015 14:00:00 GMT-0700 (PDT)"`
     `"September 24th 2015, 2:00:00 pm UTC-07:00"`
     `"2015-09-24 14:00:00 GMT-0700"`
     `"Sept 24 2015 14:00:00 GMT-0700"`
     `"Thu Sep 24 2015 14:00:00 GMT-0700 (Pacific Daylight Time)"`
     */
    public var sendAfter: String?

    /**
     A custom map of data that is passed back to your app.

     Example: `{"abc": "123", "foo": "bar"}`
     */
    public var additionalData: [String: String]?

    /**
     Adds media attachments to notifications. Set as JSON object, key as a media id of your choice and
     the value as a valid local filename or URL. User must press and hold on the notification to view.

     Do not set `mutable_content` to download attachments. The OneSignal SDK does this automatically
     */
    public var attachments: [String: String]?

    /**
     Sending true wakes your app from background to run custom native code
     (Apple interprets this as content-available=1).

     Note: Not applicable if the app is in the "force-quit" state (i.e app was swiped away).
     Omit the contents field to prevent displaying a visible notification.
     */
    public var isContentAvailable: Bool?

    /**
     Sending true allows you to change the notification content in your app before it is displayed.
     Triggers `didReceive(_:withContentHandler:)` on your `UNNotificationServiceExtension.`
     */
    public var isContentMutable: Bool?

    public init(message: String) {
        self.message = OneSignalMessage(message)
        self.users = []
    }

    public init(message: OneSignalMessage) {
        self.message = message
        self.users = []
    }

    public init(message: String, users: [String]) {
        self.message = OneSignalMessage(message)
        self.users = users
    }

    public init(message: OneSignalMessage, users: [String]) {
        self.message = message
        self.users = users
    }

    public init(title: String?, subtitle: String?, body: String, users: [String], deviceTokens: [String]? = nil, sound: String? = nil, category: String? = nil, sendAfter: String? = nil, additionalData: [String: String]? = nil, attachments: [String: String]? = nil) {
        if let title = title { self.title = OneSignalMessage(title) }
        if let subtitle = subtitle { self.subtitle = OneSignalMessage(subtitle) }
        self.message = OneSignalMessage(body)
        self.users = users
        self.sound = sound
        self.category = category
        self.sendAfter = sendAfter
        self.additionalData = additionalData
        self.attachments = attachments
    }
}

extension OneSignalNotification {
    public mutating func addUser(_ id: String) {
        self.users.append(id)
    }

    public mutating func addMessage(_ message: String, language: String = "en") {
        self.message[language] = message
    }
}

extension OneSignalNotification {
    public mutating func setTitle(_ title: String) {
        self.setTitle(OneSignalMessage(title))
    }

    public mutating func setTitle(_ message: OneSignalMessage) {
        self.title = message
    }

    public mutating func setSubtitle(_ subtitle: String) {
        self.setSubtitle(OneSignalMessage(subtitle))
    }

    public mutating func setSubtitle(_ message: OneSignalMessage) {
        self.subtitle = message
    }

    public mutating func setContentAvailable(_ isContentAvailable: Bool?) {
        self.isContentAvailable = isContentAvailable
    }

    public mutating func setContentMutability(_ isContentMutable: Bool?) {
        self.isContentMutable = isContentMutable
    }
}

extension OneSignalNotification {
    internal func generateRequest(for app: OneSignalApp) throws -> HTTPClient.Request {
        guard let url = URL(string: "https://onesignal.com/api/v1/notifications") else {
            throw OneSignalError.invalidURL
        }

        let payload = OneSignalPayload(
            appId: app.appId,
            playerIds: self.users,
            iosDeviceTokens: self.deviceTokens,
            contents: self.message.messages,
            headings: self.title?.messages,
            subtitle: self.subtitle?.messages,
            category: self.category,
            sound: self.sound,
            sendAfter: self.sendAfter,
            additionalData: self.additionalData,
            attachments: self.attachments,
            contentAvailable: self.isContentAvailable,
            mutableContent: self.isContentMutable
        )

        let bodyData: Data
        do {
            bodyData = try JSONEncoder().encode(payload)
        } catch {
            throw OneSignalError.makeRequestBodyFailed(error)
        }

        let request: HTTPClient.Request
        do {
            request = try HTTPClient.Request(
                url: url,
                method: .POST,
                headers: .init([
                    ("Authorization", "Basic \(app.apiKey)"),
                    ("Content-Type", "application/json"),
                ]),
                body: .data(bodyData)
            )
        } catch {
            throw OneSignalError.makeRequestFailed(error)
        }

        return request
    }
}
