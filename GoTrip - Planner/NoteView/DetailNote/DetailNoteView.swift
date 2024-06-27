//
//  DetailNoteView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI

struct DetailNoteView: View {
    @StateObject private var viewModel: DetailNoteViewModel
    @Environment(\.presentationMode) var presentationMode
    
    init(note: Note) {
        _viewModel = StateObject(wrappedValue: DetailNoteViewModel(note: note))
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color(CustomColors.darkBlue)
                    .ignoresSafeArea()
                ScrollView {
                    VStack(alignment: .leading) {
                        Text(viewModel.annotationTitle)
                            .font(.system(size: 14))
                            .padding(.horizontal, 10)
                            .padding(.vertical, 5)
                            .background(.blue)
                            .foregroundColor(.white)
                            .cornerRadius(16)
                        HStack(alignment: .firstTextBaseline, spacing: 0) {
                            Text(viewModel.detailText)
                                .foregroundStyle(.white)
                                .font(.system(size: 18))
                                .lineLimit(nil)
                                .multilineTextAlignment(.leading)
                            Spacer()
                        }
                        
                        Spacer()
                    }
                    .padding()
                    .navigationTitle(viewModel.note.name)
                }
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button {
                            viewModel.isShowEditView.toggle()
                        } label: {
                            Text("Edit")
                        }
                    }
                }
                .sheet(isPresented: $viewModel.isShowEditView) {
                    EditNoteView(note: $viewModel.note)
                }
            }
        }
    }
}

struct NavigationBackButton: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
        }
    }
}

#Preview {
    DetailNoteView(note: Note(name: "Страховка", detail: "найти и оплатить страховку потом отдать ее страховому агенту затем еще что-то и еще что-то а потом еще", annotation: .other, date: .now, deadline: .distantFuture))
}
