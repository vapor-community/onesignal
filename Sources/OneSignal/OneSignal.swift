//
//  OneSignal.swift
//  OneSignal
//
//  Created by Anthony Castelli on 9/5/18.
//
import Foundation
import Vapor

public final class OneSignal: ServiceType {
    
    var worker: Container
    var client: FoundationClient
    
    public static func makeService(for worker: Container) throws -> OneSignal {
        return try OneSignal(worker: worker)
    }
    
    public init(worker: Container) throws {
        self.worker = worker
        self.client = try FoundationClient.makeService(for: worker)
    }
    
    /// Send the message
    public func send(notification: OneSignalNotification, toApp app: OneSignalApp) throws -> Future<OneSignalResult> {
        return try self.client.send(notification.generateRequest(on: self.worker, for: app)).map(to: OneSignalResult.self) { response in
            guard let body = response.http.body.data, body.count != 0 else {
                return OneSignalResult.success
            }
            return OneSignalResult.error(error: OneSignalError.internal)
        }
    }

    public func sendRaw(notification: OneSignalNotification, toApp app: OneSignalApp) throws -> Future<Response> {
        return try self.client.send(notification.generateRequest(on: self.worker, for: app))
    }
    
}
