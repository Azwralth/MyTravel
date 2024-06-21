//
//  EditTripView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 20.06.2024.
//

import SwiftUI

struct EditTripView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) private var presentationMode
    
    @State private var isValid = false
    @State private var showingStartDatePicker = false
    @State private var showingEndDatePicker = false
    
    @Binding var trip: Trip
    
    init(trip: Binding<Trip>) {
        self._trip = trip
    }
    
    let rows: [GridItem] = [
        GridItem(.fixed(20))
    ]
    
    var body: some View {
        NavigationStack {
            VStack {
                CustomTextField(text: $trip.name, field: "Name")
                    .onChange(of: trip.name) { _, newValue in
                        isValid = !newValue.isEmpty && !trip.budget.formatted().isEmpty
                    }
                    .padding(.horizontal)
                    .padding(.top, 30)
                    .padding(.bottom, 105)
                
                CustomTextField(text: .init(get: { String(trip.budget) }, set: { trip.budget = $0.isEmpty ? 0 : Double($0) ?? 0 }), field: "Budget")
                    .keyboardType(.numberPad)
                    .padding(.horizontal)
                    .padding(.top, -105)
                
                Group {
                    Button(action: {
                        showingStartDatePicker.toggle()
                    }) {
                        HStack {
                            Text("Start Date: \(trip.startDate, formatter: dateFormatter)")
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
                            Text("End Date: \(trip.endDate, formatter: dateFormatter)")
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
            }
            .navigationTitle("Edit Trip")
            .background(.darkBlue)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button("Close") {
                        presentationMode.wrappedValue.dismiss()
                    }
                }
            }
            .sheet(isPresented: $showingStartDatePicker) {
                VStack {
                    DatePicker("Start Date", selection: $trip.startDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                    Button("Done") {
                        showingStartDatePicker.toggle()
//                        validateForm()
                    }
                    .padding()
                }
            }
            .sheet(isPresented: $showingEndDatePicker) {
                VStack {
                    DatePicker("End Date", selection: $trip.endDate, displayedComponents: .date)
                        .datePickerStyle(GraphicalDatePickerStyle())
                        .padding()
                    Button("Done") {
                        showingEndDatePicker.toggle()
//                        validateForm()
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
    
//    private func validateForm() {
//        if let budget = trip.budget {
//            isValid = !trip.name.isEmpty && trip.startDate <= trip.endDate
//        } else {
//            isValid = false
//        }
//    }
}
