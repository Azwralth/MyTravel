//
//  TripCellView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI

struct TripCellView: View {
    private let trip: Trip
    
    init(trip: Trip) {
        self.trip = trip
    }
    
    var body: some View {
        ZStack {
            CustomColors.customBlue
            VStack {
                HStack {
                    Spacer()
                    Text(trip.name)
                        .font(.title2)
                        .lineLimit(0)
                        .minimumScaleFactor(0.8)
                        .foregroundStyle(.white)
                        .padding()
                    Spacer()
                }
                Text("\(formattedDate(trip.startDate)) - \(formattedDate(trip.endDate))")
                    .foregroundStyle(.white)
                    .lineLimit(0)
                    .minimumScaleFactor(0.8)
                    .font(.system(size: 12))
                Spacer()
            }
            .padding(.horizontal, 20)
        }
        .frame(width: 175, height: 100)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    TripCellView(trip: Trip(name: "Франция", startDate: .now, endDate: .distantFuture, expense: [Expense(name: "coffe", expense: 12, date: .now)], budget: 3000))
}
