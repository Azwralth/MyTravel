//
//  NoteCellView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI

struct NoteCellView: View {
    @ObservedObject private var viewModel: NoteCellViewModel
    
    init(note: Note) {
        self.viewModel = NoteCellViewModel(note: note)
    }
    
    var body: some View {
        ZStack {
            CustomColors.customBlue
            VStack(alignment: .leading) {
                HStack {
                    Text(viewModel.title)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.blue)
                        .foregroundStyle(.white)
                        .font(.system(size: 13))
                        .clipShape(RoundedRectangle(cornerRadius: 20))
                        .padding([.leading, .top], 11)
                    
                    Spacer()
                    
                    Text(viewModel.formattedDate)
                        .font(.system(size: 14))
                        .foregroundStyle(.gray)
                        .offset(x: -10, y: 5)
                }
                HStack {
                    Text(viewModel.name)
                        .font(.title2)
                        .lineLimit(1)
                        .minimumScaleFactor(0.8)
                        .foregroundStyle(.white)
                    
                    Spacer()
                    
                    Text(viewModel.daysWord())
                        .font(.system(size: 14))
                        .foregroundStyle(viewModel.textColor())
                        .offset(y: 3)
                }
                .padding(.all, 10)
            }
            .padding(.horizontal, 7)
        }
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}

#Preview {
    NoteCellView(note: Note(name: "name", detail: "detail", annotation: Annotation.hotel, date: .now, image: nil, deadline: .distantFuture))
}
