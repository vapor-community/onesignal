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

    public init(httpClient: HTTPClient) {
        self.httpClient = httpClient
    }

    public init(on eventLoop: EventLoop) {
        self.httpClient = HTTPClient(eventLoopGroupProvider: .shared(eventLoop))
    }

    deinit {
        try? httpClient.syncShutdown()
    }

    /// Send the message
    public func send(notification: OneSignalNotification, toApp app: OneSignalApp, method: OneSignalNotification.Method) throws -> Future<OneSignalResult> {
        return try self.client.send(notification.generateRequest(on: self.worker, for: app, method: method)).map(to: OneSignalResult.self) { response in
            guard let body = response.http.body.data else {
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

    public func sendRaw(notification: OneSignalNotification, toApp app: OneSignalApp, method: OneSignalNotification.Method) throws -> Future<Response> {
        return try self.client.send(notification.generateRequest(on: self.worker, for: app, method: method))
    }
}
