//
//  CreateNoteView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI
import PhotosUI

struct CreateNoteView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.presentationMode) private var presentationMode
    @EnvironmentObject var lnManager: LocalNotificationManager
    
    @StateObject private var viewModel = CreateNoteViewModel()
    
    let rows: [GridItem] = [
        GridItem(.fixed(30))
    ]
    
    var body: some View {
        GeometryReader { geometry in
            NavigationStack {
                ScrollView {
                    VStack(spacing: 7) {
                        CustomTextField(text: $viewModel.name, field: "Name")
                            .onChange(of: viewModel.name) { _, newValue in
                                viewModel.updateValidity()
                            }
                            .padding(.horizontal)
                        
                        ScrollView(.horizontal) {
                            LazyHGrid(rows: rows, spacing: 1) {
                                ForEach(Annotation.allCases) { annotation in
                                    Button(action: {
                                        viewModel.annotation = annotation
                                    }) {
                                        Text(annotation.title)
                                            .font(.system(size: 14))
                                            .padding(.horizontal, 10)
                                            .padding(.vertical, 5)
                                            .background(.blue)
                                            .foregroundColor(.white)
                                            .opacity(viewModel.annotation == annotation ? 1 : 0.4)
                                            .cornerRadius(16)
                                            .padding(.leading, 16)
                                    }
                                }
                            }
                            .padding(.trailing, 20)
                        }
                        .scrollIndicators(.hidden)
                        
                        CustomTextField(text: $viewModel.detail, field: "Detail")
                            .padding(.horizontal)
                        
                        
                        Group {
                            HStack {
                                Text("Deadline:")
                                    .foregroundStyle(.gray)
                                Spacer()
                                if lnManager.isGranted {
                                    DatePicker("", selection: $viewModel.deadline)
                                        .colorScheme(.dark)
                                        .padding(.trailing, 10)
                                        .tint(.white)
                                }
                            }
                        }
                        .padding(.leading, 20)
                        .frame(minHeight: 65)
                        .background(CustomColors.darkBlue)
                        .overlay(RoundedRectangle(cornerRadius: 20).stroke(.gray, lineWidth: 1))
                        .padding(.horizontal)
                        
                        Spacer()
                        
                        Button(action: {
                            Task {
                                let dateComponents = Calendar.current.dateComponents([.year, .month, .day, .hour, .minute], from: viewModel.deadline)
                                let localNotification = LocalNotification(
                                    identifier: UUID().uuidString,
                                    title: viewModel.name,
                                    body: "Deadline now",
                                    dateComponents: dateComponents,
                                    repeats: false
                                )
                                await lnManager.schedule(localNotification: localNotification)
                            }
                            viewModel.saveNote(modelContext: modelContext, presentationMode: presentationMode)
                        }) {
                            Text("Add")
                                .frame(maxWidth: .infinity)
                                .padding()
                                .foregroundColor(.white)
                        }
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .opacity(!viewModel.isValid ? 0.3 : 1)
                        .disabled(!viewModel.isValid)
                        .padding()
                        .padding(.top, -15)
                    }
                    .padding(.top, 10)
                }
                .navigationTitle("New Note")
                .background(CustomColors.darkBlue)
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button("Close") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                .task {
                    try? await lnManager.requestAuthorization()
                }
            }
        }
    }
}

#Preview {
    CreateNoteView()
        .environmentObject(LocalNotificationManager())
}
