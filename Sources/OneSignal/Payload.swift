//
//  Payload.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//

import Foundation
import Vapor

struct Payload: Content {
    enum CodingKeys: CodingKey, String {
        case appId = "appId"
        case playerIds = "include_player_ids"
        
        case contents = "contents"
        case headings = "headings"
        case subtitle = "subtitle"
        
        case contentAvailable = "content_available"
        case mutableContent = "mutable_content"
    }
    
    var appId: String

    var playerIds: [String]
    
    var contents: Message
    
    var headings: Message?
    var subtitle: Message?
    
    var contentAvailable: Bool?
    var mutableContent: Bool?
}

