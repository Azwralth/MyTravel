//
//  ExpenseCellView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 19.06.2024.
//

import SwiftUI

struct ExpenseCellView: View {
    private let expense: Expense
    
    init(expense: Expense) {
        self.expense = expense
    }
    
    var body: some View {
        ZStack {
            CustomColors.customBlue
            VStack {
                HStack {
//                    Spacer()
                    Text("\(formattedDate(expense.date))")
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                        .padding(.leading, -3)
                        .padding(.top, 20)
                    Spacer()
                }
                HStack {
                    Text(expense.name)
                        .padding([.top, .leading], -4)
                        .foregroundStyle(.white)
                        .lineLimit(nil)
                        .minimumScaleFactor(0.7)
                    .font(.system(size: 20))
                    Spacer()
                }
                
                Text("-\(expense.expense.formatted())")
                    .foregroundStyle(.red)
                    .font(.system(size: 30))
                    .padding(.bottom, 20)
                    .padding(.leading, -70)
                    .padding(.top, 10)
            }
            .padding(.horizontal, 20)
        }
        .frame(maxWidth: 170, maxHeight: 130)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
    
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
}

#Preview {
    ExpenseCellView(expense: Expense(name: "шоколадка", expense: 150, date: .now))
}
