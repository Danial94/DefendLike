//
//  SimulateView.swift
//  DefendLike
//
//  Created by Danial Tan on 25/07/2024.
//

import Foundation
import SwiftUI

struct SimulateView: View {
    @ObservedObject var zDefendManager: ZDefendManager = ZDefendManager.shared
    
    var body: some View {
        VStack {
            Button(action: {
                zDefendManager.runSimulatedThreat(id: 13)
            }) {
                Text("Malware")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            Button(action: {
                zDefendManager.runSimulatedThreat(id: 24)
            }) {
                Text("Untrusted Profile")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            Button(action: {
                zDefendManager.runSimulatedThreat(id: 45)
            }) {
                Text("Suspicious Profile")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            Button(action: {
                zDefendManager.runSimulatedThreat(id: 42)
            }) {
                Text("Suspicious Application")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            Button(action: {
                zDefendManager.runSimulatedThreat(id: 93)
            }) {
                Text("Out of Compliance Application")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            Button(action: {
                zDefendManager.onThreatMitigated()
            }) {
                Text("Mitigate Simulated Threat")
                    .frame(maxWidth: .infinity)
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding(.horizontal)
            Spacer()
        }
        .frame(maxWidth: .infinity)
        .navigationBarTitle("Simulate", displayMode: .inline)
    }
}
