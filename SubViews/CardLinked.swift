//
//  CardLinked.swift
//  DefendLike
//
//  Created by Danial Tan on 30/07/2024.
//

import Foundation
import SwiftUI

struct CardLinked: View {
    @ObservedObject var linked: LinkedModel
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Text(linked.label)
                    .font(.headline)
                Spacer()
                Text("\(linked.threats.count)")
                    .monospaced()
            }
            Text(linked.eventType)
                .padding(.top, 5)
                .monospaced()
            Text(linked.description)
                .font(.subheadline)
                .foregroundColor(.secondary)
        }
        .padding()
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
        .padding([.top])
    }
}
