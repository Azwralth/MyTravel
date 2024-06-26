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
    @State private var showingStartDatePicker = false
    @State private var showingEndDatePicker = false
    
    let rows: [GridItem] = [
        GridItem(.fixed(20))
    ]
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack {
                    CustomTextField(text: $name, field: "Name")
                        .onChange(of: name) { _, newValue in
                            isValid = !newValue.isEmpty && !budget.isEmpty
                        }
                        .padding(.horizontal)
                        .padding(.bottom, 90)
                        .minimumScaleFactor(0.8)
                    
                    CustomTextField(text: $budget, field: "Budget")
                        .onChange(of: budget) { _, newValue in
                            isValid = !newValue.isEmpty && !name.isEmpty
                        }
                        .keyboardType(.numberPad)
                        .padding(.horizontal)
                        .padding(.top, -95)
                    
                    Group {
                        Button(action: {
                            showingStartDatePicker.toggle()
                        }) {
                            HStack {
                                Text("Start Date: \(startDate, formatter: dateFormatter)")
                                    .foregroundStyle(.gray)
                                Spacer()
                                Image(systemName: "calendar")
                                    .foregroundStyle(.gray)
                                    .padding()
                            }
                        }
                        Button(action: {
                            showingEndDatePicker.toggle()
                        }) {
                            HStack {
                                Text("End Date: \(endDate, formatter: dateFormatter)")
                                    .foregroundStyle(.gray)
                                Spacer()
                                Image(systemName: "calendar")
                                    .foregroundStyle(.gray)
                                    .padding()
                            }
                        }
                    }
                    .padding(.leading, 20)
                    .frame(minHeight: 65)
                    .background(CustomColors.darkBlue)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(Color.gray, lineWidth: 1))
                    .padding(.horizontal)
                    .padding(.bottom, 25)
                    .padding(.top, -20)
                    
                    Spacer()
                    
                    Button(action: {
                        if let budgetValue = Double(budget) {
                            let newTrip = Trip(name: name, startDate: startDate, endDate: endDate, budget: budgetValue)
                            modelContext.insert(newTrip)
                            presentationMode.wrappedValue.dismiss()
                        }
                    }) {
                        Text("Add")
                    }
                    .frame(maxWidth: .infinity)
                    .padding(.vertical)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .opacity(!isValid ? 0.3 : 1)
                    .disabled(!isValid)
                    .padding()
                }
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
            .sheet(isPresented: $showingStartDatePicker) {
                VStack {
                    DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                    Button("Done") {
                        showingStartDatePicker.toggle()
                        validateForm()
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $showingEndDatePicker) {
                VStack {
                    DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                    Button("Done") {
                        showingEndDatePicker.toggle()
                        validateForm()
                    }
                    .padding()
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

