//
//  OneSignalNotification.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//

import Foundation
import Vapor

public struct OneSignalNotification: Codable {
    enum CodingKeys: CodingKey, String {
        case users = "users"
        
        case title = "title"
        case subtitle = "subtitle"
        case message = "message"
        
        case category = "category"
        
        case sound = "ios_sound"
        
        case isContentAvailable = "content_available"
        case isContentMutable = "mutable_content"
    }
    
    public var users: [String]
    
    public var title: OneSignalMessage?
    public var subtitle: OneSignalMessage?
    public var message: OneSignalMessage
    
    public var category: String?
    
    public var sound: String?
    
    public var isContentAvailable: Bool?
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
    
    public init(title: String, subtitle: String, message: String, users: [String], sound: String? = nil, category: String? = nil) {
        self.title = OneSignalMessage(title)
        self.subtitle = OneSignalMessage(subtitle)
        self.message = OneSignalMessage(message)
        self.users = users
        self.sound = sound
        self.category = category
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
    internal func generateRequest(on container: Container, for app: OneSignalApp) throws -> Request {
        let request = Request(using: container)
        request.http.method = .POST
        
        request.http.headers.add(name: .connection, value: "Keep-Alive")
        request.http.headers.add(name: HTTPHeaderName("authorization"), value: "Basic \(app.apiKey)")
        
        let payload = OneSignalPayload(
            appId: app.appId,
            playerIds: self.users,
            contents: self.message,
            headings: self.title,
            subtitle: self.subtitle,
            contentAvailable: self.isContentAvailable,
            mutableContent: self.isContentMutable
        )
        
        let encoder = JSONEncoder()
        request.http.body = try HTTPBody(data: encoder.encode(payload))
        
        guard let url = URL(string: "https://onesignal.com/api/v1/notifications") else {
            throw OneSignalError.invalidURL
        }
        request.http.url = url
        
        return request
    }
}
