//
//  ContentView.swift
//  REPCC (iOS)
//
//  Created by Elias Skibb on 10.10.25.
//

import SwiftUI
import SafariServices
import AVFoundation


var ip = "hahaha"


struct HeaderView: View {
    var body: some View {
        VStack {
            Text("RePCC").font(.largeTitle.bold()).foregroundColor(Color.white)
            Text("Your all in one (computer) Remote").foregroundColor(Color.white)
        }
    }
}

struct RepeatingTextView: View {
    private let phrase = "secure - free - open source - control - remote - desktop - live"

    // Animation speed
    let duration: Double = 20.0

    var body: some View {
        GeometryReader { fullGeo in
            VStack(spacing: -26) {
                ForEach(0..<10, id: \.self) { rowIndex in
                    let dir: CGFloat = (rowIndex % 2 == 0) ? 1.0 : -1.0
                    
                    Text(phrase).foregroundStyle(Color.white)
                }
            }.frame(maxWidth: .infinity, maxHeight: .infinity).ignoresSafeArea()
        }
    }
}

struct SafariView: UIViewControllerRepresentable {
    let url: URL
    
    func makeUIViewController(context: Context) -> SFSafariViewController {
        let safariVC = SFSafariViewController(url: url)
        return safariVC
    }
    
    func updateUIViewController(_ uiViewController: SFSafariViewController, context: Context) {
        // Foxy was here :)
    }
}

struct ConfirmView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background").ignoresSafeArea()

                Color(
                    red: 72.0 / 255.0,
                    green: 47.0 / 255.0,
                    blue: 47.0 / 225.0,
                    opacity: 1
                ).edgesIgnoringSafeArea(.top).frame(maxWidth: .infinity, maxHeight: 17).padding(0).position(x: 201, y: 0)

                HeaderView().position(x: 200, y: 70)

                Color(
                    red: 72.0 / 255.0,
                    green: 47.0 / 255.0,
                    blue: 47.0 / 225.0,
                    opacity: 1
                ).edgesIgnoringSafeArea(.bottom).frame(maxWidth: .infinity, maxHeight: 50).padding(0).position(x: 201, y: 800)
            }
        }
    }
}

func ipLive(ip: String) async -> Bool{
    var success = false
    
    
    
    return success
}

struct ManualIPSearchView: View {
    @State private var console = "$> \(ip)"
    var  body: some View {
        NavigationStack {
            ZStack {
                Color("background").ignoresSafeArea()
                
                VStack {
                    HeaderView().position(x: 200, y: 50)
                    
                    ZStack {
                        Color(
                            red: 45.0 / 255.0,
                            green: 45.0 / 255.0,
                            blue: 45.0 / 255.0,
                            opacity: 1
                        ).frame(width: 350, height: 250)
                        
                        Text(console).foregroundColor(.white).frame(width: 330, height: 230)
                    }.position(x: 200, y: 0).shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                }
            }
        }
    }
}

struct ManualIPView: View {
    @State private var hi = ""
    @State private var showError = false
    
    @State private var Oct1: String = ""
    @State private var Oct2: String = ""
    @State private var Oct3: String = ""
    @State private var Oct4: String = ""
    
    enum OctetField: Hashable {
        case Oct1, Oct2, Oct3, Oct4
    }
    
    @FocusState private var focusedField: OctetField?
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background").ignoresSafeArea()

                VStack {
                    HeaderView()
                    
                    VStack {
                        Text("Enter your host's IP:").foregroundColor(.white)
                        HStack {
                            ZStack {
                                Color(
                                    red: 45.0 / 255.0,
                                    green: 45.0 / 255.0,
                                    blue: 45.0 / 255.0,
                                    opacity: 1
                                ).frame(width: 290, height: 60).cornerRadius(20).shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                                
                                HStack {
                                    ZStack {
                                        Color(
                                            red: 45.0 / 255.0,
                                            green: 45.0 / 255.0,
                                            blue: 45.0 / 255.0,
                                            opacity: 1
                                        ).frame(width: 60, height: 40).cornerRadius(5).shadow(color: .black.opacity(0.15), radius: 5, x: 0, y: 5)
                                        TextField("", text: $Oct1, prompt: Text("192").foregroundColor(.white.opacity(0.3)))
                                            .keyboardType(.numberPad)
                                            .frame(width: 60, height: 40)
                                            .offset(x: 15)
                                            .onChange(of: Oct1) { v in
                                                if let val = Int(v), (0...255).contains(val) {
                                                    // valid
                                                    if v.count == 3 {
                                                        Oct1 = String(v.prefix(3))
                                                        
                                                    }
                                                } else if !v.isEmpty {
                                                    Oct1 = "255"
                                                }
                                            }
                                    }
                                    
                                    ZStack {
                                        Color(
                                            red: 45.0 / 255.0,
                                            green: 45.0 / 255.0,
                                            blue: 45.0 / 255.0,
                                            opacity: 1
                                        ).frame(width: 60, height: 40).cornerRadius(5).border(.black.opacity(0.3), width: 1)
                                        TextField("", text: $Oct2, prompt: Text("168").foregroundColor(.white.opacity(0.3))).frame(width: 60, height: 40).offset(x: 15)
                                    }
                                    
                                    ZStack {
                                        Color(
                                            red: 45.0 / 255.0,
                                            green: 45.0 / 255.0,
                                            blue: 45.0 / 255.0,
                                            opacity: 1
                                        ).frame(width: 60, height: 40).cornerRadius(5).border(.black.opacity(0.3), width: 1)
                                        TextField("", text: $Oct3, prompt: Text("178").foregroundColor(.white.opacity(0.3))).frame(width: 60, height: 40).offset(x: 15)
                                    }
                                    
                                    ZStack {
                                        Color(
                                            red: 45.0 / 255.0,
                                            green: 45.0 / 255.0,
                                            blue: 45.0 / 255.0,
                                            opacity: 1
                                        ).frame(width: 60, height: 40).cornerRadius(5).border(.black.opacity(0.3), width: 1)
                                        TextField("", text: $Oct4, prompt: Text("155").foregroundColor(.white.opacity(0.3))).frame(width: 60, height: 40).offset(x: 15)
                                    }
                                }
                            }
                            
                            Color(
                                red: 0.0 / 255.0,
                                green: 0.0 / 255.0,
                                blue: 0.0 / 255.0,
                                opacity: 0
                            ).frame(width: 1, height: 50)
                            
                            NavigationLink(destination: ManualIPSearchView()) {
                                ZStack {
                                    Color(
                                        red: 45.0 / 255.0,
                                        green: 45.0 / 255.0,
                                        blue: 45.0 / 255.0,
                                        opacity: 1
                                    ).frame(width: 50, height: 50).cornerRadius(10).shadow(color: .black.opacity(0.3), radius: 5, x: 0, y: 5)
                                    Text(">").foregroundColor(.white).opacity(0.5)
                                }
                            }
                        }
                    }.position(x: 200, y: 300)
                }
            }
        }
    }
}

struct ConnectView: View {
    var body: some View {
        NavigationStack {
            ZStack {
                Color("background").ignoresSafeArea()

                VStack {
                    HeaderView()
                    
                    Color(
                        red: 0.0 / 255.0,
                        green: 0.0 / 255.0,
                        blue: 0.0 / 255.0,
                        opacity: 0
                    ).frame(width: 1, height: 150)
                    
                    Color(
                        red: 217.0 / 255.0,
                        green: 217.0 / 255.0,
                        blue: 217.0 / 255.0,
                        opacity: 1
                    ).frame(width: 250, height: 200)
                    
                    NavigationLink(destination: ManualIPView()) {
                        ZStack {
                            Color(
                                red: 217.0 / 255.0,
                                green: 217.0 / 255.0,
                                blue: 217.0 / 255.0,
                                opacity: 1
                            ).frame(width: 250, height: 50).cornerRadius(20)
                            VStack {
                                Text("Enter IP").foregroundColor(Color.black)
                                Text("manually").foregroundColor(Color.black)
                            }
                        }
                    }
                    
                    Color(
                        red: 0.0 / 255.0,
                        green: 0.0 / 255.0,
                        blue: 0.0 / 255.0,
                        opacity: 0
                    ).frame(width: 250, height: 200)
                }
            }
        }
    }
}

struct ContentView: View {
    @Environment(\.openURL) var openURL
    @State private var showingHelpSheet: Bool = false

    var body: some View {
        NavigationStack {
            ZStack {
                Color("background").ignoresSafeArea()

                RepeatingTextView()
                    .opacity(0.15)
                    .padding(0)
                    .position(x: 200, y: 100)
                
                VStack {
                    NavigationLink(destination: ConnectView()) {
                        ZStack {
                            Color(
                                red: 232.0 / 255.0,
                                green: 255.0 / 255.0,
                                blue: 227.0 / 255.0,
                                opacity: 1
                            ).frame(maxWidth: 250, maxHeight: 50).cornerRadius(20.0)
                            Text("Connect").font(.largeTitle).foregroundColor(.black)
                        }
                    }
                    Button(action: {
                        showingHelpSheet.toggle()
                    }) {
                        ZStack {
                            Color(
                                red: 255.0 / 255.0,
                                green: 254.0 / 255.0,
                                blue: 228.0 / 255.0,
                                opacity: 1
                            ).frame(maxWidth: 250, maxHeight: 50).cornerRadius(20.0)
                            Text("Set-Up Help").font(.largeTitle).foregroundColor(.black)
                        }
                    }
                }.position(x: 200, y: 550)
            }.sheet(isPresented: $showingHelpSheet) {
                if let url = URL(string: "https://github.com/teelichtfoxy/repcc/blob/main/README.md#ios-setup-help") {
                    SafariView(url: url)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
