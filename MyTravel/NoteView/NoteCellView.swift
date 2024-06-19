//
//  NoteCellView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI

struct NoteCellView: View {
    private let note: Note
    
    init(note: Note) {
        self.note = note
    }
    
    var body: some View {
        ZStack {
            CustomColors.customBlue
            VStack(alignment: .leading) {
                Text(note.annotation.title)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(.blue)
                    .foregroundStyle(.white)
                    .font(.system(size: 13))
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding([.leading, .top], 11)
                HStack {
                    Text(note.name)
                        .font(.title2)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .foregroundStyle(.white)
                    Spacer()
                }
                .padding(.all, 10)
            }
            .padding(.horizontal, 16)
        }
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    NoteCellView(note: Note(name: "name", detail: "detail", annotation: Annotation.hotel))
}