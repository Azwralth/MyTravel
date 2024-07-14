//
//  SettingScreenView.swift
//  GoTrip - Planner
//
//  Created by Владислав Соколов on 10.07.2024.
//

import SwiftUI
import StoreKit

struct SettingScreenView: View {
    @Environment(\.modelContext) var modelContext
    @State private var showingResetAlert = false
    @State private var showSuccessAlert = false
    @State private var selectedIcon: Icons? = nil
    
    var body: some View {
        let viewModel = SettingScreenViewModel(modelContext: modelContext)
        NavigationStack {
            VStack {
                List {
                    ForEach(viewModel.menuIcons, id: \.self) { icon in
                        Button {
                            if icon == .reset {
                                selectedIcon = icon
                                showingResetAlert = true
                            } else {
                                viewModel.performAction(for: icon)
                            }
                        } label: {
                            SettingCellView(image: icon.rawValue, name: icon.buttonName, colorButton: icon == .reset ? .red : CustomColors.customBlue)
                        }
                        .listRowBackground(CustomColors.darkBlue)
                        .listRowInsets(EdgeInsets())
                    }
                }
                .alert(isPresented: $showSuccessAlert) {
                    Alert(title: Text("Success"), message: Text("All data has been successfully deleted"), dismissButton: .default(Text("OK")))
                }
                .offset(y: 10)
                .scrollDisabled(true)
                .listRowSpacing(15)
                .listStyle(.insetGrouped)
                .scrollContentBackground(.hidden)
                .padding(.leading, -5)
            }
            .background(CustomColors.darkBlue)
            .navigationTitle("Settings")
            .alert("Reset All Data", isPresented: $showingResetAlert) {
                Button("Cancel", role: .cancel) {}
                Button("Reset", role: .destructive) {
                    if let icon = selectedIcon {
                        viewModel.performAction(for: icon)
                        showSuccessAlert.toggle()
                    }
                }
            } message: {
                Text("Are you sure you want to reset all your progress?")
            }
        }
    }
}

#Preview {
    SettingScreenView()
}
