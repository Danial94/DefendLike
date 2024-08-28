//
//  LinkedModel.swift
//  DefendLike
//
//  Created by Danial Tan on 30/07/2024.
//

import Foundation

class LinkedModel: Identifiable, ObservableObject {
    let id: String
    let label: String
    @Published var description: String
    @Published var eventType: String
    @Published var threats: [ThreatModel]
    
    init(id: String, label: String, description: String, eventType: String, threats: [ThreatModel]) {
        self.id = id
        self.label = label
        self.description = description
        self.eventType = eventType
        self.threats = threats
    }
}
