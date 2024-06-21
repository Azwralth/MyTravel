//
//  DefaultContentView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 20.06.2024.
//

import SwiftUI

struct DefaultContentView: View {
    private let name: String
    
    init(name: String) {
        self.name = name
    }
    
    var body: some View {
        ZStack {
            Color(CustomColors.darkBlue)
                .ignoresSafeArea()
            VStack {
                Text(name)
                    .foregroundColor(.gray)
                    .font(.title2).bold()
                    .padding(.bottom, 10)
                Text("Нажмите на \(Image(systemName: "plus.circle.fill")) чтобы начать")
                    .foregroundColor(.gray)
                    .font(.headline)
            }
            .padding()
        }
    }
}

#Preview {
    DefaultContentView(name: "")
}
