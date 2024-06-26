//
//  ExpenseCellView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 19.06.2024.
//

import SwiftUI

struct ExpenseCellView: View {
    private let expense: Expense
    private let action: () -> Void
    
    init(expense: Expense, action: @escaping () -> Void) {
        self.expense = expense
        self.action = action
    }
    
    var body: some View {
        ZStack {
            CustomColors.customBlue
            VStack {
                HStack {
                    Text(expense.date.formattedDate())
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                        .padding(.leading, -3)
                        .padding(.top, 20)
                    Spacer()
                    Button(action: action) {
                        Image(systemName: "trash")
                            .foregroundStyle(.gray)
                            .padding(.top, 20)
                    }
                }
                HStack {
                    Text(expense.name)
                        .padding([.top, .leading], -4)
                        .foregroundStyle(.white)
                        .lineLimit(0)
                        .minimumScaleFactor(0.7)
                    .font(.system(size: 20))
                    Spacer()
                }
                
                HStack {
                    Text("-\(expense.expense.formatted())")
                        .foregroundStyle(.red)
                        .font(.system(size: 30))
                        .padding(.bottom, 20)
                    .padding(.top, 10)
                    Spacer()
                }
            }
            .padding(.horizontal, 20)
        }
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    ExpenseCellView(expense: Expense(name: "шоколадка", expense: 150, date: .now), action: {})
}
