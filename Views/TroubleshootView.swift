//
//  TroubleshootView.swift
//  DefendLike
//
//  Created by Danial Tan on 25/07/2024.
//

import Foundation
import SwiftUI

struct TroubleshootView: View {
    @ObservedObject var zDefendManager: ZDefendManager = ZDefendManager.shared
    @State private var selectedTab = 0
    
    var body: some View {
        VStack(alignment: .leading) {
            Picker("Select a tab", selection: $selectedTab) {
                Text("Logs").tag(0)
                Text("Details").tag(1)
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            if selectedTab == 0 {
                ScrollView {
                    if (zDefendManager.troubleshootLogs.isEmpty) {
                        Text("Loading...")
                    }
                    Text(zDefendManager.troubleshootLogs)
                        .monospaced()
                        .font(.system(size: 11))
                        .padding([.horizontal, .bottom])
                }
            } else {
                ScrollView {
                    if (zDefendManager.troubleshootDetails.isEmpty) {
                        Text("Loading...")
                    }
                    Text(zDefendManager.troubleshootDetails)
                        .monospaced()
                        .font(.system(size: 11))
                        .padding([.horizontal, .bottom])
                }
            }
        }
        .onAppear() {
            zDefendManager.getLogs()
            zDefendManager.getLogDetails()
        }
        .navigationBarTitle("Troubleshoot", displayMode: .inline)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}
