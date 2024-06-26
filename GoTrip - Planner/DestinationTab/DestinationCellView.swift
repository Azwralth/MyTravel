//
//  DestinationCellView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 19.06.2024.
//

import SwiftUI

struct DestinationCellView: View {
    private let destination: Destination
    
    init(destination: Destination) {
        self.destination = destination
    }
    
    var body: some View {
        ZStack {
            CustomColors.customBlue
            HStack {
                VStack(alignment: .leading) {
                    Text(destination.name)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                    Text("^[\(destination.placemarks.count) \("location")](inflect: true)")
                        .font(.system(size: 17))
                        .foregroundStyle(.white)
                }
                .padding()
                Spacer()
            }
        }
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    DestinationCellView(destination: Destination(name: "Russia"))
}
