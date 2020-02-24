//
//  OneSignalResult.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//

import Foundation
import Vapor

public enum OneSignalError: Swift.Error {
    case `internal`
    case invalidURL
    case apiKeyNotSet
    case appIDNotSet
    case requestError(value: String)
}

public enum OneSignalResult: ResponseCodable {
    case success
    case error(error: OneSignalError)
    case networkError(error: Error)
}
