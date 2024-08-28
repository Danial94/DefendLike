//
//  PolicyView.swift
//  DefendLike
//
//  Created by Danial Tan on 24/07/2024.
//

import Foundation
import SwiftUI

struct PolicyView: View {
    @ObservedObject var zDefendManager: ZDefendManager = ZDefendManager.shared
    
    var body: some View {
        VStack {
            if (zDefendManager.policies.isEmpty) {
                VStack {
                    Text("Loading...")
                }
            } else {
                VStack(alignment: .leading) {
                    ScrollView {
                        ForEach(zDefendManager.policies) { policy in
                            Text(policy.description)
                                .padding([.horizontal, .bottom])
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .navigationBarTitle("Policies", displayMode: .inline)
        .onAppear() {
            zDefendManager.getPolicies()
        }
    }
}
