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
    @State private var annotation: Annotation = .flight
    @State private var isValid = false
    @State private var showingStartDatePicker = false
    @State private var showingEndDatePicker = false
    
    let rows: [GridItem] = [
        GridItem(.fixed(20))
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextField(text: $name, field: "Name")
                    .onChange(of: name) { _, newValue in
                        isValid = !newValue.isEmpty && !budget.isEmpty
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)
                    .padding(.bottom, 105)
                
                CustomTextField(text: $budget, field: "Budget")
                    .onChange(of: budget) { _, newValue in
                        isValid = !newValue.isEmpty && !name.isEmpty
                    }
                    .keyboardType(.numberPad)
                    .padding(.horizontal)
                    .padding(.top, -105)
                
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
                .background(.darkBlue)
                .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
                .padding(.horizontal)
                .padding(.bottom, 35)
                .padding(.top, -30)
                
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
                .frame(width: 350, height: 60)
                .background(.blue)
                .foregroundStyle(.white)
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .opacity(!isValid ? 0.3 : 1)
                .disabled(!isValid)
            }
            .navigationTitle("New Trip")
            .background(.darkBlue)
            .toolbar {
                ToolbarItem(placement: .navigationBarLeading) {
                    Button("Cancel") {
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
            isValid = !name.isEmpty && !budget.isEmpty && startDate <= endDate
        } else {
            isValid = false
        }
    }
}


#Preview {
    CreateTripView()
}
