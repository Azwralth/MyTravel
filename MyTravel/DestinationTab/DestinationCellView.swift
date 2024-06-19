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
                    Image(systemName: "globe")
                        .resizable()
                        .frame(width: 30, height: 30)
                        .foregroundStyle(.blue)
                    VStack(alignment: .leading) {
                        Text("123")
                            .foregroundStyle(.white)
                            .font(.title3)
                        Text("^[\(destination.placemarks.count) location](inflect: true)")
                            .font(.system(size: 17))
                            .foregroundStyle(.white)
                    }
                }
        }
        .frame(width: 180, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        
        
    }
}

#Preview {
    DestinationCellView(destination: Destination(name: ""))
}
