//
//  ContentView.swift
//  REPCC
//
//  Created by Elias Skibb on 07.10.25.
//

import SwiftUI
import Foundation
import AppKit
import CoreImage

let baseURL = "http://localhost:15248"

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

func genQRCode(text: String) -> NSImage? {
    guard let data = text.data(using: .ascii) else { return nil }
    guard let qrcifilter = CIFilter(name: "CIQRCodeGenerator") else { return nil }
    
    qrcifilter.setValue(data, forKey: "inputMessage")
    qrcifilter.setValue("L", forKey: "inputCorrectionLevel")

    guard let ciimage = qrcifilter.outputImage else { return nil }

    let transform = CGAffineTransform(scaleX: 8, y: 8)
    let scaledCIImage = ciimage.transformed(by: transform)
    let rep = NSCIImageRep(ciImage: scaledCIImage)
    let nsImage = NSImage(size: rep.size)
    nsImage.addRepresentation(rep)
  
    return nsImage
}

func startREPCCService() async {
    let fullURLString = "\(baseURL)/wakeup"
    guard let url = URL(string: fullURLString) else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    do {
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            DispatchQueue.main.async {
                print("Started!")
                print(httpResponse)
            }
        }
    } catch {
        print("Network Error: \(error)")
    }
}

func stopREPCCService() async {
    let fullURLString = "\(baseURL)/sleep"
    guard let url = URL(string: fullURLString) else { return }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    do {
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            DispatchQueue.main.async {
                print("Stopped!")
            }
        }
    } catch {
        print("Network Error: \(error)")
    }
}

func A() async {
    let fullURLString = "\(baseURL)/keyboard"
    guard let url = URL(string: fullURLString) else { return }
    
    do {
        try await Task.sleep(nanoseconds: 3_000_000_000)
        print("3 Seconds Over")
    } catch {
        print("Await Error: \(error)")
    }
    
    var request = URLRequest(url: url)
    request.httpMethod = "POST"
    
    struct KeyCommand: Codable {
        let key: UInt16
        let modifier: UInt32
    }
    let command = KeyCommand(key: 0x00, modifier: 0)
    
    do {
        let encoder = JSONEncoder()
        request.httpBody = try encoder.encode(command)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let (_, response) = try await URLSession.shared.data(for: request)
        
        if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
            print("Success!")
        } else {
            print("Error!")
        }
    } catch {
        print("Error: \(error)")
    }
}

struct TestAPIView: View {
    @Environment(\.dismiss) var dismiss
    var body: some View {
        VStack {
            Text("HI").font(Font.largeTitle).bold().padding()
            VStack {
                HStack {
                    Button("A") {
                        Task {
                            await A()
                        }
                    }
                    Button("B") {
                        
                    }
                }
                HStack {
                    Button("<") {
                        
                    }
                    Button(">") {
                        
                    }
                }
            }
            Button("Close") {
                dismiss()
            }
        }.padding(50)
    }
}

struct ContentView: View {
    @State private var showTestAPIView = false
    @State private var ipAddress: String = "Lade IP-Adresse..."
    @State private var tfaCode: String = "Generiere Code..."
    @State private var repccRunning: Bool = false
    @State private var qrCodeText: String = "https://google.com"
    
    var qrCodeImage: NSImage? {
        genQRCode(text: qrCodeText)
    }
    
    var body: some View {
        VStack {
            if let image = qrCodeImage {
                Image(nsImage: image).padding()
            }
            Text("IP: " + ipAddress).font(Font.largeTitle).bold().padding()
            Text("2FA Code: " + tfaCode).font(Font.title).bold().padding()
            Text("Status: " + (repccRunning ? "Läuft" : "Gestoppt"))
            HStack {
                Button("Starten") {
                    Task {
                        await startREPCC()
                    }
                }.disabled(repccRunning)
                Button("Stoppen") {
                    Task {
                        await stopREPCC()
                    }
                }.disabled(!repccRunning)
            }
            Button("Test API") {
                showTestAPIView = true
            }.padding()
        }.padding(50).onAppear() {
            updateIPAdress()
            updateTFACode()
            Task {
                await startREPCC()
            }
        }.sheet(isPresented: $showTestAPIView) {
            TestAPIView()
        }
    }
    
    func startREPCC() async {
        updateIPAdress()
        updateTFACode()
        updateQRCode()
        await startREPCCService()
        repccRunning = true
    }
    
    func stopREPCC() async {
        repccRunning = false
        await stopREPCCService()
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
    
    func updateQRCode() {
        qrCodeText = String(ipAddress + ":" + tfaCode)
    }
}

#Preview {
    ContentView()
}
