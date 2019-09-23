//
//  OneSignalPayload.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//

import AsyncHTTPClient
import Foundation

public struct OneSignalPayload: Encodable {
    enum CodingKeys: String, CodingKey {
        case appId = "app_id"
        case playerIds = "include_player_ids"
        case iosDeviceTokens = "include_ios_tokens"
        case segments = "included_segments"
        case excludedSegments = "excluded_segments"

        case contents
        case headings
        case subtitle

        case category = "ios_category"

        case sound = "ios_sound"
        case sendAfter = "send_after"
        case additionalData = "data"
        case attachments = "ios_attachments"

        case contentAvailable = "content_available"
        case mutableContent = "mutable_content"
    }

    public var appId: String
    
    public var playerIds: [String]?
    public var iosDeviceTokens: [String]?
    public var segments: [String]?
    public var excludedSegments: [String]?
    
    public var contents: [String: String]
    public var headings: [String: String]?
    public var subtitle: [String: String]?

    public var category: String?
    public var sound: String?
    public var sendAfter: String?
    public var additionalData: [String: String]?
    public var attachments: [String: String]?

    public var contentAvailable: Bool?
    public var mutableContent: Bool?
}
