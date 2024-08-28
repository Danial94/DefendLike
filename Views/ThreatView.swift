//
//  ThreatView.swift
//  DefendLike
//
//  Created by Danial Tan on 24/07/2024.
//

import Foundation
import SwiftUI
import ZDefend

struct ThreatView: View {
    @ObservedObject var zDefendManager: ZDefendManager = ZDefendManager.shared
    @State private var expandedItems: Set<String> = []
    
    @State private var severityFilterText: String = "ALL"
    @State private var mitigatedFilterText: String = "ALL"
    var filteredThreats: [ThreatModel] {
        zDefendManager.threats.filter { threat in
            (severityFilterText == "ALL" || threat.severity == severityFilterText) &&
            (mitigatedFilterText == "ALL" || threat.status == (mitigatedFilterText == "FIXED"))
        }
    }
    
    var body: some View {
        VStack {
            if (zDefendManager.threats.isEmpty) {
                VStack {
                    Text("Loading...")
                }
            } else {
                VStack(alignment: .leading) {
                    HStack {
                        Menu {
                            Button("ALL") {
                                severityFilterText = "ALL"
                            }
                            Button("CRITICAL") {
                                severityFilterText = "CRITICAL"
                            }
                            Button("IMPORTANT") {
                                severityFilterText = "IMPORTANT"
                            }
                            Button("LOW") {
                                severityFilterText = "LOW"
                            }
                        } label: {
                            Text(severityFilterText)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                        Menu {
                            Button("ALL") {
                                mitigatedFilterText = "ALL"
                            }
                            Button("FIXED") {
                                mitigatedFilterText = "FIXED"
                            }
                            Button("PENDING") {
                                mitigatedFilterText = "PENDING"
                            }
                        } label: {
                            Text(mitigatedFilterText)
                                .frame(maxWidth: .infinity)
                                .padding()
                                .background(Color.accentColor)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    .padding(.horizontal)
                    ScrollView {
                        ForEach(filteredThreats) { threat in
                            CardAccordian(
                                threat: threat,
                                isExpanded: Binding(
                                get: { self.expandedItems.contains(threat.id) },
                                set: { isExpanded in
                                    if isExpanded {
                                        self.expandedItems.insert(threat.id)
                                    } else {
                                        self.expandedItems.remove(threat.id)
                                    }
                                }
                            ))
                            .padding(.horizontal)
                        }
                    }
                }
                .frame(maxHeight: .infinity, alignment: .top)
            }
        }
        .navigationBarTitle("Threats", displayMode: .inline)
        .onAppear() {
            zDefendManager.getThreats()
        }
    }
}
