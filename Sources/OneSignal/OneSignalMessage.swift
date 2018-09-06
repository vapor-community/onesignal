//
//  OneSignalMessage.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//

import Foundation

public struct OneSignalMessage: Codable {
    private var messages: [String : String]
    
    public init(_ message: String) {
        // English is required by `OneSignal`
        self.messages = ["en": message]
    }
    
    public subscript(key: String) -> String? {
        get {
            return self.messages[key]
        }
        set {
            self.messages[key] = newValue
        }
    }
}
