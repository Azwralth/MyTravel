//
//  DetailNoteView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI

struct DetailNoteView: View {
    @StateObject private var viewModel: DetailNoteViewModel
    
    init(note: Note) {
        _viewModel = StateObject(wrappedValue: DetailNoteViewModel(note: note))
    }
    
    var body: some View {
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
                    
                    if !(viewModel.note.image?.isEmpty ?? true) {
                        Button {
                            viewModel.isShowingImage.toggle()
                        } label: {
                            Text(viewModel.imageButtonText)
                        }
                    }
                    
                    if viewModel.isShowingImage, let image = viewModel.note.image {
                        withAnimation {
                            Image(uiImage: UIImage(data: image)!)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 300)
                                .padding(.top, 20)
                        }
                    }
                    
                    if viewModel.isShowingImage {
                        Button {
                            viewModel.isShowingShareSheet = true
                        } label: {
                            Text("Поделиться")
                        }
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
            .sheet(isPresented: $viewModel.isShowingShareSheet) {
                if let imageData = viewModel.note.image, let uiImage = UIImage(data: imageData) {
                    ShareSheet(activityItems: [uiImage])
                }
            }
        }
    }
}

#Preview {
    DetailNoteView(note: Note(name: "Страховка", detail: "найти и оплатить страховку потом отдать ее страховому агенту затем еще что-то и еще что-то а потом еще", annotation: .other, date: .now, image: nil, deadline: .distantFuture))
}
