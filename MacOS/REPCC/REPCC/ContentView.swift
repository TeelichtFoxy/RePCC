//
//  ContentView.swift
//  REPCC
//
//  Created by Elias Skibb on 07.10.25.
//

import SwiftUI
import Foundation

func getLocalIPAddress() -> String? {
    var address: String?
    
    var ifaddress: UnsafeMutablePointer<ifaddrs>?
    
    guard getifaddrs(&ifaddress) == 0 else { return nil }
    guard let firstAddress = ifaddress else { return nil }
    
    for ptr in sequence(first: firstAddress, next: { $0.pointee.ifa_next }) {
        let interface = ptr.pointee
        
        let addrFamily = interface.ifa_addr.pointee.sa_family
        
        if addrFamily == UInt8(AF_INET) {
            let name = String(cString: interface.ifa_name)
            if name == "en0" {
                var hostname = [CChar](repeating: 0, count: Int(NI_MAXHOST))
                
                getnameinfo(interface.ifa_addr, socklen_t(interface.ifa_addr.pointee.sa_len), &hostname, socklen_t(hostname.count), nil, socklen_t(0), NI_NUMERICHOST)
                
                address = String(cString: hostname)
                break
            }
        }
    }
    
    freeifaddrs(ifaddress)
    return address
}

func genTFACode() -> String {
    let min: Int = 111111
    let max: Int = 999999
    
    let code = Int.random(in: min...max)
    
    return String(code)
}

struct ContentView: View {
    @State private var ipAddress: String = "Lade IP-Adresse..."
    @State private var tfaCode: String = "Generiere Code..."
    @State private var repccRunning: Bool = true
    
    var body: some View {
        VStack {
            Text("IP: " + ipAddress).font(Font.largeTitle).bold().padding()
            Text("2FA Code: " + tfaCode).font(Font.title).bold().padding()
            HStack {
                Button("Starten") {
                    startREPCC()
                }.disabled(repccRunning)
                Button("Stoppen") {
                    stopREPCC()
                }.disabled(!repccRunning)
            }
        }.padding(50).onAppear() {
            updateIPAdress()
            updateTFACode()
        }
    }
    
    func startREPCC() {
        repccRunning = true
        updateIPAdress()
        updateTFACode()
    }
    
    func stopREPCC() {
        repccRunning = false
        tfaCode = "Gestoppt"
    }
    
    func updateIPAdress() {
        if let ip = getLocalIPAddress() {
            ipAddress = ip
        } else {
            ipAddress = "Konnte IP-Adresse nicht ermitteln."
        }
    }
    
    func updateTFACode() {
        tfaCode = genTFACode()
    }
}

#Preview {
    ContentView()
}
