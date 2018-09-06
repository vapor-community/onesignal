//
//  OneSignalPayload.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//

import Foundation
import Vapor

public struct OneSignalPayload: Content {
    enum CodingKeys: CodingKey, String {
        case appId = "appId"
        case playerIds = "include_player_ids"
        
        case contents = "contents"
        case headings = "headings"
        case subtitle = "subtitle"
        
        case contentAvailable = "content_available"
        case mutableContent = "mutable_content"
    }
    
    public var appId: String

    public var playerIds: [String]
    
    public var contents: OneSignalMessage
    
    public var headings: OneSignalMessage?
    public var subtitle: OneSignalMessage?
    
    public var contentAvailable: Bool?
    public var mutableContent: Bool?
}

