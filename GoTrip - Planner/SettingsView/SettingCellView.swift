//
//  SettingCellView.swift
//  GoTrip - Planner
//
//  Created by Владислав Соколов on 10.07.2024.
//

import SwiftUI

struct SettingCellView: View {
    let image: String
    let name: String
    var colorButton: Color = CustomColors.customBlue
    
    
    var body: some View {
        ZStack {
            VStack(alignment: .leading) {
                HStack {
                    Image(systemName: image)
                        .font(.largeTitle)
                        .frame(width: 40, height: 40)
                        .foregroundStyle(.white)
                        .padding(.leading, 27)
                        .padding(.top, 20)
                    Spacer()
                }
                Text(name)
                    .foregroundStyle(.white)
                    .padding(.leading, 30)
                    .padding(.top, 10)
                    .padding(.bottom, 10)
            }
        }
        .background(colorButton)
        .clipShape(RoundedRectangle(cornerRadius: 25))
    }
}

#Preview {
    SettingCellView(image: "square.and.arrow.up.fill", name: "Rate app")
}
