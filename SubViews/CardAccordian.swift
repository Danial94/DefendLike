//
//  CardView.swift
//  DefendLike
//
//  Created by Danial Tan on 24/07/2024.
//

import Foundation
import SwiftUI

struct CardAccordian: View {
    @ObservedObject var threat: ThreatModel
    @Binding var isExpanded: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(threat.name)
                    .font(.headline)
                    .foregroundColor(.primary)
                Spacer()
                Button(action: {
                    withAnimation {
                        isExpanded.toggle()
                    }
                }) {
                    Image(systemName: isExpanded ? "chevron.up" : "chevron.down")
                        .foregroundColor(.primary)
                }
            }
            if isExpanded {
                HStack {
                    Text(threat.severity)
                        .font(.subheadline)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                    Text(threat.status ? "FIXED" : "PENDING")
                        .font(.subheadline)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(threat.status ? Color.green : Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                Text(threat.description)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 10)
                Text(threat.resolution)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
                    .padding(.top, 10)
            }
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding([.top])
    }
}
