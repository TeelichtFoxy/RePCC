//
//  main.swift
//  REPCCService
//
//  Created by Elias Skibb on 08.10.25.
//

import Vapor
import Foundation
import Carbon
import CoreGraphics

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

let modifierKeyCodes: [CGKeyCode: CGEventFlags] = [
    0x37: .maskCommand,
    0x38: .maskShift,
    0x3B: .maskControl
]

func simulateShortcut(keys: [CGKeyCode]) {
    guard keys.count > 0, let mainKeyCode = keys.last else {
        print("Error")
        return
    }
    
    var modifierFlags: CGEventFlags = []
    let modifierKeys = keys.dropLast()
    
    for key in modifierKeys {
        if let flag = modifierKeyCodes[key] {
            modifierFlags.insert(flag)
        }
    }
    
    guard let source = CGEventSource(stateID: .combinedSessionState) else {
        print("ERROR")
        return
    }
    
    if let keyDownEvent = CGEvent(keyboardEventSource: source, virtualKey: mainKeyCode, keyDown: true) {
        keyDownEvent.flags = modifierFlags
        keyDownEvent.post(tap: .cghidEventTap)
        
        print("KeyDown: \(mainKeyCode) with flags: \(modifierFlags) \(keyDownEvent.flags)")
    }
    
    usleep(10000)
    
    if let keyUpEvent = CGEvent(keyboardEventSource: source, virtualKey: mainKeyCode, keyDown: false) {
        keyUpEvent.flags = modifierFlags
        keyUpEvent.post(tap: .cghidEventTap)
        print("KeyUp: \(mainKeyCode) with flags: \(modifierFlags)")
    }
    
    print("Simulated Shortcut: \(keys)")
}

simulateShortcut(keys: [0x37,0x31])

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

extension Bundle {
    var appVersion: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
    }
    
    var buildNumber: String {
        return infoDictionary?["CFBundleShortVersionString"] as? String ?? "N/A"
    }
    
    var fullVersion: String {
        return "\(appVersion) (\(buildNumber))"
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
        
        let ARoutes = app.routes.grouped(SleepCheckMiddleware())
        
        app.http.server.configuration.port = stateManager.currenSettings.apiPort
        print("Service starting on port \(stateManager.currenSettings.apiPort)...")
        
        app.routes.get("status") { req -> String in
            if req.application.serviceStateManager.isSleeping {
                return "Service stopped"
            }
            return "Service is running at port \(stateManager.currenSettings.apiPort)"
        }
        
        app.routes.get("version") { req -> String in
            return Bundle.main.fullVersion
        }
        
        app.routes.post("sleep") { req -> HTTPStatus in
            req.application.serviceStateManager.setSleeping(true)
            
            return .ok
        }
        
        app.routes.post("wakeup") { req -> HTTPStatus in
            req.application.serviceStateManager.setSleeping(false)
            
            return .ok
        }
        
        //Keyboard
        //Key
        ARoutes.post("keyboard","key") { req -> HTTPStatus in
            let command = try req.content.decode(KeyCommand.self)
            
            simulateKey(key: command.key)
            
            return .ok
        }
        //Shortcut
        ARoutes.post("keyboard","shortcut") { req -> HTTPStatus in
            
            
            return .ok
        }
        
        try app.run()
    } catch {
        print("Service startup error: \(error)")
        exit(1)
    }
}
main()
