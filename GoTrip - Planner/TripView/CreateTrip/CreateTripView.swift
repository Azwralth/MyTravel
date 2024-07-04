//
//  CreateTripView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI

struct CreateTripView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var name = ""
    @State private var budget = ""
    @State private var startDate = Date()
    @State private var endDate = Date()
    @State private var isValid = false
    @State private var currency = "USD"
    @State private var showingStartDatePicker = false
    @State private var showingEndDatePicker = false
    @State private var showingDataRangePicker = false
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ScrollView {
                    VStack(spacing: 7) {
                        CustomTextField(text: $name, field: "Name")
                            .onChange(of: name) { _, newValue in
                                isValid = !newValue.isEmpty && !budget.isEmpty
                            }
                            .padding(.horizontal)
                        
                        HStack {
                            CustomTextField(text: $budget, field: "Budget")
                                .onChange(of: budget) { _, newValue in
                                    isValid = !newValue.isEmpty && !name.isEmpty
                                }
                                .keyboardType(.numberPad)
                                .padding(.horizontal)
                                .padding(.trailing, -30)
                            
                            Picker("Currency", selection: $currency) {
                                ForEach(DataStore.shared.getAllCurrncies(), id: \.self) { currency in
                                    Text(currency).tag(currency)
                                }
                            }
                            .frame(width: geometry.size.width / 3)
                            .frame(minHeight: 65)
                            .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
                            .padding(.horizontal)
                        }
                        
                        Group {
                            Button(action: {
                                showingDataRangePicker.toggle()
                            }) {
                                HStack {
                                    Text("\(startDate, formatter: dateFormatter) - \(endDate, formatter: dateFormatter)")
                                        .frame(
                                            width: geometry.size.width / 1.4,
                                            height: 65,
                                            alignment: .leading
                                        )
                                    .foregroundStyle(.gray)
                                    Image(systemName: "calendar")
                                        .foregroundStyle(.gray)
                                        .padding()
                                }
                            }
                        }
                        .padding(.leading, 20)
                        .frame(minHeight: 65)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
                        .padding(.horizontal)
                        
                        Button(action: {
                            if let budgetValue = Double(budget) {
                                let newTrip = Trip(name: name, startDate: startDate, endDate: endDate, expense: [], budget: budgetValue, currency: currency)
                                modelContext.insert(newTrip)
                                presentationMode.wrappedValue.dismiss()
                            }
                        }) {
                            Text("Add")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                        }
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .opacity(!isValid ? 0.3 : 1)
                        .disabled(!isValid)
                        .padding()
                    }
                    .padding(.top, 10)
                }
                .background(CustomColors.darkBlue)
                .navigationTitle("New Trip")
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Close") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .sheet(isPresented: $showingDataRangePicker) {
                    DateRangePickerView(startDate: $startDate, endDate: $endDate)
                        .presentationDetents([.height(600)])
                }
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
    
    private func validateForm() {
        if let _ = Double(budget) {
            isValid = startDate <= endDate
        } else {
            isValid = false
        }
    }
}

#Preview {
    CreateTripView()
}

