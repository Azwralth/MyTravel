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
    
    let defaultCurrency = "USD"
    
    init(trip: Binding<Trip>) {
        self._trip = trip
    }
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                VStack(spacing: 7) {
                    CustomTextField(text: $trip.name, field: "Name")
                        .onChange(of: trip.name) { _, newValue in
                            isValid = !newValue.isEmpty && !trip.budget.formatted().isEmpty
                        }
                        .padding(.horizontal)
                    
                    HStack {
                        CustomTextField(text: .init(get: { String(trip.budget) }, set: { trip.budget = $0.isEmpty ? 0 : Double($0) ?? 0 }), field: "Budget")
                            .keyboardType(.numberPad)
                            .padding(.horizontal)
                            .padding(.trailing, -30)
                        
                        Picker("Currency", selection: $trip.currency) {
                            ForEach(DataStore.shared.getAllCurrncies(), id: \.self) { currency in
                                Text(currency).tag(currency)
                            }
                        }
                        .frame(width: geometry.size.width / 3)
                        .frame(minHeight: 65)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
                        .padding(.horizontal)
                        .onAppear {
                            if trip.currency.isEmpty {
                                trip.currency = defaultCurrency
                            }
                        }
                    }
                    
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
                    .background(CustomColors.darkBlue)
                    .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
                    .padding(.horizontal)
                    
                    Spacer()
                }
                .navigationTitle("Edit Trip")
                .background(CustomColors.darkBlue)
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
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
                        }
                    }
                }
                .sheet(isPresented: $showingEndDatePicker) {
                    VStack {
                        DatePicker("End Date", selection: $trip.endDate, displayedComponents: .date)
                            .datePickerStyle(GraphicalDatePickerStyle())
                            .padding()
                        Button("Done") {
                            showingEndDatePicker.toggle()
                        }
                    }
                }
            }
        }
    }
    
    private var dateFormatter: DateFormatter {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        return formatter
    }
}

#Preview {
    EditTripView(trip: .constant(Trip(name: "Russia", startDate: .now, endDate: .distantFuture, expense: [], budget: 1000, currency: "USD")))
}


