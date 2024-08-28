//
//  ThreatCard.swift
//  DefendLike
//
//  Created by Danial Tan on 24/07/2024.
//

import Foundation

class ThreatModel: Identifiable, ObservableObject {
    let id: String
    let name: String
    let severity: String
    let status: Bool
    let description: String
    let resolution: String
    
    init(id: String, name: String, severity: String, status: Bool, description: String, resolution: String) {
        self.id = id
        self.name = name
        self.severity = severity
        self.status = status
        self.description = description
        self.resolution = resolution
    }
}
