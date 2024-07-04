//
//  DateRangePickerView.swift
//  GoTrip - Planner
//
//  Created by Владислав Соколов on 04.07.2024.
//

import SwiftUI

struct DateRangePickerView: View {
    @Binding var startDate: Date
    @Binding var endDate: Date
    @Environment(\.presentationMode) var presentationMode
    @State private var isSelectingStartDate = true
    
    var body: some View {
        VStack {
            if isSelectingStartDate {
                Text("Start Date")
                    .font(.title)
                
                DatePicker("Start Date", selection: $startDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                Button("Next") {
                    withAnimation {
                        isSelectingStartDate.toggle()
                    }
                }
                .padding()
            } else {
                Text("End Date")
                    .font(.title)
                
                DatePicker("End Date", selection: $endDate, displayedComponents: .date)
                    .datePickerStyle(GraphicalDatePickerStyle())
                    .padding()
                Button("Done") {
                    presentationMode.wrappedValue.dismiss()
                }
                .padding()
            }
        }
        .padding()
    }
}
