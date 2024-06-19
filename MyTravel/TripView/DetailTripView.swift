//
//  DetailTripView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI

struct DetailTripView: View {
    @State private var showingAlert = false
    @State private var expenseName = ""
    @State private var expenseAmount = ""
    @State private var expenseDate = Date()
    
    private let trip: Trip
    
    init(trip: Trip) {
        self.trip = trip
    }
    
    var body: some View {
        ZStack {
            Color(CustomColors.darkBlue)
                .ignoresSafeArea()
            VStack(alignment: .leading) {
                Text("\(formattedDate(trip.startDate)) - \(formattedDate(trip.endDate))")
                    .foregroundStyle(.white)
                    .lineLimit(0)
                    .font(.system(size: 14))
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.blue)
                    .foregroundColor(.white)
                    .cornerRadius(16)
                HStack(alignment: .firstTextBaseline, spacing: 0) {
                    Text("Бюджет - \(trip.budget.formatted())")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                    Spacer()
                }
                Text("Остаток \(currentBalanceTrip())")
                    .foregroundStyle(.gray)
                    .font(.system(size: 10))
                    .padding(.leading, 2)
                    .padding(.bottom, 20)
                
                ScrollView {
                    LazyVGrid(columns: [GridItem(.fixed(170)), GridItem(.fixed(170))]) {
                        ForEach(trip.expense) { expense in
                            ExpenseCellView(expense: expense)
                        }
                    }
                }
                .padding(.leading, -10)
                .scrollIndicators(.hidden)
                
                Spacer()
            }
            .padding()
            .navigationTitle(trip.name)
            .navigationBarTitleTextColor(.white)
            .toolbar {
                ToolbarItem {
                    Button(action: {
                        showingAlert.toggle()
                    }) {
                        Label("Add Note", systemImage: "plus.circle.fill")
                    }
                }
            }
            .alert("Create new expense", isPresented: $showingAlert, actions: {
                TextField("Expense Name", text: $expenseName)
                TextField("Expense Amount", text: $expenseAmount)
                    .keyboardType(.decimalPad)
                Button("Add", action: addExpense)
                Button("Cancel", role: .cancel, action: {})
            }, message: {
                Text("Enter the details of the new expense")
            })
        }
    }
    private func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "dd.MM.yyyy"
        return formatter.string(from: date)
    }
    
    private func currentBalanceTrip() -> String {
        let totalBudget = trip.budget
        let totalExpenses = trip.expense.reduce(0.0) { $0 + $1.expense }
        let currentBalance = totalBudget - totalExpenses
        return String(format: "%.2f", currentBalance)
    }
    
    private func addExpense() {
        withAnimation {
            guard let amount = Double(expenseAmount) else { return }
            let newExpense = Expense(name: expenseName, expense: amount, date: Date())
            trip.expense.append(newExpense)
            expenseName = ""
            expenseAmount = ""
        }
    }
}

#Preview {
    DetailTripView(trip: Trip(name: "Франция", startDate: .now, endDate: .distantFuture, expense: [Expense(name: "coffe", expense: 4, date: .now)], budget: 3000))
}
