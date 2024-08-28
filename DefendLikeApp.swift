//
//  DefendLikeApp.swift
//  DefendLike
//
//  Created by Danial Tan on 20/06/2024.
//

import SwiftUI

@main
struct DefendLikeApp: App {
    @Environment(\.scenePhase) private var scenePhase
    @ObservedObject var zDefendManager: ZDefendManager = ZDefendManager.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: scenePhase) { oldPhase, newPhase in
            switch newPhase {
            case .background:
                zDefendManager.auditLogs.append("DefendLikeApp - onChangeScenePhase (\(newPhase))")
            case .inactive:
                zDefendManager.deregisterZDefend()
            case .active:
                zDefendManager.initializeZDefend()
            @unknown default:
                zDefendManager.auditLogs.append("DefendLikeApp - onChangeScenePhase (\(newPhase))")
            }
        }
    }
}
