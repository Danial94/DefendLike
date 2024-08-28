//
//  LinkedView.swift
//  DefendLike
//
//  Created by Danial Tan on 30/07/2024.
//

import Foundation
import SwiftUI

struct LinkedView: View {
    @ObservedObject var zDefendManager: ZDefendManager = ZDefendManager.shared
    @State private var inputText: String = ""
    
    var body: some View {
        VStack(alignment: .leading) {
            TextField("Enter Function Label", text: $inputText)
                .padding()
                .frame(height: 50)
                .font(.system(size: 20))
                .textFieldStyle(RoundedBorderTextFieldStyle())
            HStack() {
                Button(action: {
                    zDefendManager.registerLinkedFunction(input: inputText)
                    self.inputText = ""
                }) {
                    Text("Register")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.accentColor)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
                Button(action: {
                    zDefendManager.deregisterAllLinkedFunctions()
                }) {
                    Text("Unregister")
                        .frame(maxWidth: .infinity)
                        .padding()
                        .background(Color.red)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .padding(.horizontal)
            ScrollView {
                ForEach(zDefendManager.linkedObjects) { linked in
                    CardLinked(linked: linked)
                }
                .padding(.horizontal)
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
        }
        .navigationBarTitle("Linked", displayMode: .inline)
        .frame(maxWidth: .infinity, alignment: .leading)
    }
}
