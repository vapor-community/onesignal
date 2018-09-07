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
        case appId = "app_id"
        case playerIds = "include_player_ids"
        
        case contents = "contents"
        case headings = "headings"
        case subtitle = "subtitle"
        
        case contentAvailable = "content_available"
        case mutableContent = "mutable_content"
    }
    
    public var appId: String

    public var playerIds: [String]
    
    public var contents: [String: String]
    
    public var headings: [String: String]?
    public var subtitle: [String: String]?
    
    public var contentAvailable: Bool?
    public var mutableContent: Bool?
}

