//
//  CustomTextField.swift
//  MyTravel
//
//  Created by Владислав Соколов on 19.06.2024.
//

import SwiftUI

struct CustomTextField: View {
    @Binding var text: String
    var field: String
    
    var body: some View {
        TextField(text: $text) {
            Text(field)
                .foregroundStyle(.gray)
        }
        .padding(.leading, 20)
        .frame(minHeight: 65)
        .foregroundStyle(.white)
        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
        .padding(.vertical, 4)
    }
}

#Preview {
    CustomTextField(text: .constant("123"), field: "Add")
}
