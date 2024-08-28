//
//  ContentView.swift
//  DefendLike
//
//  Created by Danial Tan on 20/06/2024.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var zDefendManager: ZDefendManager = ZDefendManager.shared
    
    var body: some View {
        if (!zDefendManager.isLoaded) {
            VStack {
                Text("Initializing...")
            }
        } else {
            NavigationView {
                GeometryReader { geometry in
                    VStack {
                        let size = geometry.size.width * 0.4
                        let spacing = geometry.size.width / 16
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: spacing) {
                            NavigationLink(destination: ThreatView()) {
                                CardButton(label: "Threats", icon: "exclamationmark.triangle", color: .accentColor, width: size, height: size)
                            }
                            NavigationLink(destination: PolicyView()) {
                                CardButton(label: "Policies", icon: "doc.text", color: .accentColor, width: size, height: size)
                            }
                            NavigationLink(destination: TroubleshootView()) {
                                CardButton(label: "Troubleshoot", icon: "wrench.and.screwdriver", color: .accentColor, width: size, height: size)
                            }
                            NavigationLink(destination: SimulateView()) {
                                CardButton(label: "Simulate", icon: "play.circle", color: .accentColor, width: size, height: size)
                            }
                            NavigationLink(destination: AuditView()) {
                                CardButton(label: "Audit", icon: "magnifyingglass.circle", color: .accentColor, width: size, height: size)
                            }
                            NavigationLink(destination: LinkedView()) {
                                CardButton(label: "Linked", icon: "link.circle", color: .accentColor, width: size, height: size)
                            }
                        }
                        .padding()
                    }
                    .navigationBarTitle("ZDemo", displayMode: .inline)
                    .navigationBarItems(
                        leading: Button(action: {
                            zDefendManager.checkForUpdates()
                        }) {
                            Image(systemName: "arrow.clockwise")
                        }
                    )
                    .frame(maxHeight: .infinity, alignment: .top)
                }
            }
        }
    }
}

#Preview {
    ContentView()
}
