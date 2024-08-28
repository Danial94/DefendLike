//
//  CardButton.swift
//  DefendLike
//
//  Created by Danial Tan on 24/07/2024.
//

import Foundation
import SwiftUI

struct CardButton: View {
    let label: String
    let icon: String
    let color: Color
    let width: CGFloat
    let height: CGFloat
    
    var body: some View {
        VStack {
            Image(systemName: icon)
                .font(.largeTitle)
                .foregroundColor(.white)
            Text(label)
                .font(.headline)
                .foregroundColor(.white)
        }
        .padding()
        .frame(width: width, height: height)
        .background(color)
        .cornerRadius(10)
        .shadow(radius: 5)
    }
}
