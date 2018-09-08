//
//  OneSignalApp.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//

import Foundation

public struct OneSignalApp: Codable {
    enum CodingKeys: String, CodingKey {
        case apiKey = "api_key"
        case appId = "app_id"
    }
    
    public var apiKey: String
    public var appId: String
    
    public init(apiKey: String, appId: String) {
        self.apiKey = apiKey
        self.appId = appId
    }
}
