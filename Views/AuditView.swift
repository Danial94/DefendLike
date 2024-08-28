//
//  AuditView.swift
//  DefendLike
//
//  Created by Danial Tan on 26/07/2024.
//

import Foundation
import SwiftUI

struct AuditView: View {
    @ObservedObject var zDefendManager: ZDefendManager = ZDefendManager.shared
    
    var body: some View {
        VStack {
            if (zDefendManager.auditLogs.isEmpty) {
                VStack {
                    Text("Loading...")
                }
            } else {
                VStack(alignment: .leading) {
                    ScrollView {
                        Text(zDefendManager.auditLogs)
                            .monospaced()
                            .font(.system(size: 11))
                            .padding([.horizontal, .bottom])
                    }
                    Spacer()
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .navigationBarTitle("Audit", displayMode: .inline)
    }
}
