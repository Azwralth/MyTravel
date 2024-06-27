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
            VStack(alignment: .leading) {
                HStack {
                    Text("Budget - \(trip.budget.formatted()) \(trip.currency)")
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .font(.system(size: 13))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding([.leading, .top], 11)
                    Spacer()
                    Text("\(trip.startDate.formattedDate()) - \(trip.endDate.formattedDate())")
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                        .offset(y: 5)
                }
                HStack {
                    Text(trip.name)
                        .font(.title2)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.all, 10)
            }
            .padding(.horizontal, 7)
        }
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}


#Preview {
    TripCellView(trip: Trip(name: "Франция", startDate: .now, endDate: .distantFuture, expense: [Expense(name: "coffe", expense: 12, date: .now)], budget: 3000, currency: "USD"))
}
