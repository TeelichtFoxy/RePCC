//
//  main.swift
//  REPCCService
//
//  Created by Elias Skibb on 08.10.25.
//

import Vapor
import Foundation
import Carbon

struct ServiceSettings: Codable {
    var apiPort: Int = 15248
    var loggingEnabled: Bool = true
    var sleeping: Bool = false
}

struct KeyCommand: Content {
    let key: UInt16
}

func loadSettings() -> ServiceSettings {
    return ServiceSettings()
}

func simulateKey(key: UInt16) {
    print("HI")
    guard let keyDownEvent = CGEvent(keyboardEventSource: nil, virtualKey: key, keyDown: true) else {
        print("Error creating KeyDown Event")
        return
    }
    
    guard let keyUpEvent = CGEvent(keyboardEventSource: nil, virtualKey: key, keyDown: false) else {
        print("Error creating KeyUp Event")
        return
    }
    
    keyDownEvent.post(tap: .cghidEventTap)
    
    usleep(1000)
    
    keyUpEvent.post(tap: .cghidEventTap)
    
    print("Simulated Key: \(key)")
}

extension Application {
    var serviceStateManager: ServiceStateManager {
        get {
            guard let manager = self.storage[ServiceStateManagerKey.self] else {
                fatalError("ServiceStateManager not registered into Application.")
            }
            return manager
        }
        set {
            self.storage[ServiceStateManagerKey.self] = newValue
        }
    }
    
    private struct ServiceStateManagerKey: StorageKey {
        typealias Value = ServiceStateManager
    }
}

final class ServiceStateManager {
    var currenSettings: ServiceSettings
    
    private let lock = Lock()
    
    init(initialSettings: ServiceSettings) {
        self.currenSettings = initialSettings
    }
    
    var isSleeping: Bool {
        lock.lock()
        defer { lock.unlock() }
        return currenSettings.sleeping
    }
    
    func setSleeping(_ value: Bool) {
        lock.lock()
        defer { lock.unlock() }
        currenSettings.sleeping = value
    }
}

struct SleepCheckMiddleware: Middleware {
    func respond(to request: Request, chainingTo next: Responder) -> EventLoopFuture<Response> {
        let stateManager = request.application.serviceStateManager
        
        
        if stateManager.isSleeping {
            return request.eventLoop.makeSucceededFuture(
                Response(status: .serviceUnavailable, body: .init(string: "Service is currently stopped."))
            )
        }
        return next.respond(to: request)
    }
}

func main() {
    do {
        let initialSettings = loadSettings()
        let app = try Application(.detect())
        
        let stateManager = ServiceStateManager(initialSettings: initialSettings)
        
        app.serviceStateManager = stateManager
        
        let routes = app.routes.grouped(SleepCheckMiddleware())
        
        app.http.server.configuration.port = stateManager.currenSettings.apiPort
        print("Service starting on port \(stateManager.currenSettings.apiPort)...")
        
        routes.get("status") { req -> String in
            return "Service is running at port \(stateManager.currenSettings.apiPort)"
        }
        
        routes.get("version") { req -> String in
            return "0.1.0"
        }
        
        app.routes.post("sleep") { req -> HTTPStatus in
            req.application.serviceStateManager.setSleeping(true)
            
            return .ok
        }
        
        app.routes.post("wakeup") { req -> HTTPStatus in
            req.application.serviceStateManager.setSleeping(false)
            
            return .ok
        }
        
        app.routes.post("keybord") { req -> HTTPStatus in
            return .ok
            print(req.content)
            let command = try req.content.decode(KeyCommand.self)
            
            simulateKey(key: command.key)
            
            print("KEYYYYY")
            print(command.key)
            
            return .ok
        }
        
        try app.run()
    } catch {
        print("Service startup error: \(error)")
        exit(1)
    }
}
main()
