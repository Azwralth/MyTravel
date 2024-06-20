//
//  DetailNoteView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI

struct DetailNoteView: View {
    private let note: Note
    
    init(note: Note) {
        self.note = note
    }
    
    var body: some View {
        ZStack {
            Color(CustomColors.darkBlue)
                .ignoresSafeArea()
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
                
                
                Spacer()
            }
            .padding()
            .navigationTitle(note.name)
        }
    }
}

#Preview {
    DetailNoteView(note: Note(name: "Страховка", detail: "найти и оплатить страховку потом отдать ее страховому агенту затем еще что-то и еще что-то а потом еще", annotation: .other))
}
