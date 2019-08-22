//
//  OneSignal.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//

import AsyncHTTPClient
import Foundation
import NIO

public final class OneSignal {
    let httpClient: HTTPClient

    public init(httpClient: HTTPClient? = nil) {
        self.httpClient = httpClient ?? HTTPClient(eventLoopGroupProvider: .createNew)
    }

    /// Send the message
    public func send(notification: OneSignalNotification, toApp app: OneSignalApp) throws -> EventLoopFuture<OneSignalResult> {
        return try self.sendRaw(notification: notification, toApp: app).map { response in
            guard var responseBody = response.body, let body = responseBody.readBytes(length: responseBody.readableBytes) else {
                return OneSignalResult.error(error: OneSignalError.internal)
            }

            guard response.status == .ok else {
                if let message = String(bytes: body, encoding: .utf8) {
                    return OneSignalResult.error(error: OneSignalError.requestError(value: message))
                }
                return OneSignalResult.error(error: OneSignalError.internal)
            }
            return OneSignalResult.success
        }
    }

    public func sendRaw(notification: OneSignalNotification, toApp app: OneSignalApp) throws -> EventLoopFuture<HTTPClient.Response> {
        return try self.httpClient.execute(request: notification.generateRequest(for: app))
    }
}
