//
//  DetailNoteView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI

struct DetailNoteView: View {
    @State private var isShowingImage = false
    @State private var isShowingShareSheet = false
    
    private let note: Note
    
    init(note: Note) {
        self.note = note
    }
    
    var body: some View {
        ZStack {
            Color(CustomColors.darkBlue)
                .ignoresSafeArea()
            ScrollView {
                VStack(alignment: .leading) {
                    Text(note.annotation.title)
                        .font(.system(size: 14))
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .foregroundColor(.white)
                        .cornerRadius(16)
                    HStack(alignment: .firstTextBaseline, spacing: 0) {
                        Text(note.detail)
                            .foregroundStyle(.white)
                            .font(.system(size: 18))
                            .lineLimit(nil)
                            .multilineTextAlignment(.leading)
                        Spacer()
                    }
                    
                    if !(note.image?.isEmpty ?? true) {
                        Button {
                            isShowingImage.toggle()
                        } label: {
                            Text(isShowingImage ? "Скрыть изображения" : "Показать изображение")
                        }
                    }
                    
                    if isShowingImage, let image = note.image {
                        withAnimation {
                            Image(uiImage: UIImage(data: image)!)
                                .resizable()
                                .scaledToFit()
                                .frame(maxHeight: 300)
                                .padding(.top, 20)
                        }
                    }
                    
                    if isShowingImage {
                        Button {
                            isShowingShareSheet = true
                        } label: {
                            Text("Поделиться")
                        }
                    }
                    
                    Spacer()
                }
                .padding()
                .navigationTitle(note.name)
            }
            .sheet(isPresented: $isShowingShareSheet) {
                if let imageData = note.image, let uiImage = UIImage(data: imageData) {
                    ShareSheet(activityItems: [uiImage])
                }
            }
        }
    }
}

#Preview {
    DetailNoteView(note: Note(name: "Страховка", detail: "найти и оплатить страховку потом отдать ее страховому агенту затем еще что-то и еще что-то а потом еще", annotation: .other, date: .now, image: nil, deadline: .distantFuture))
}
