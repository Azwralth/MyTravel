//
//  LaunchView.swift
//  MyTravel
//
//  Created by Владислав Соколов on 18.06.2024.
//

import SwiftUI

struct LaunchView: View {
    @ObservedObject var viewModel = LaunchViewModel()
    
    var body: some View {
        ZStack {
            Rectangle()
                .ignoresSafeArea()
            GeometryReader { geometry in
                VStack {
                    Image("photo_2")
                        .resizable()
                        .frame(width: geometry.size.width, height: geometry.size.height / 1.4)
                    HStack {
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: geometry.size.width / 35)
                            .foregroundStyle(viewModel.currentPage == .first ? .blue : .customBlue)
                            .background(viewModel.currentPage == .first ? .blue : .customBlue)
                            .clipShape(Circle())
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: geometry.size.width / 35)
                            .foregroundStyle(viewModel.currentPage == .second ? .blue : .customBlue)
                            .background(viewModel.currentPage == .second ? .blue : .customBlue)
                            .clipShape(Circle())
                        Image(systemName: "circle")
                            .resizable()
                            .frame(width: geometry.size.width / 35)
                            .foregroundStyle(viewModel.currentPage == .third ? .blue : .customBlue)
                            .background(viewModel.currentPage == .third ? .blue : .customBlue)
                            .clipShape(Circle())
                    }
                    
                    Text(viewModel.getTitle())
                        .font(.title)
                        .foregroundStyle(.white)
                    
                    Text(viewModel.getSubTitle())
                        .foregroundStyle(.gray)
                        .padding(.bottom, 15)
                    
                    Button(action: viewModel.switchCurrentPage) {
                        Text("Next")
                            .foregroundStyle(.white)
                    }
                    .frame(width: geometry.size.width / 1.2, height: geometry.size.height / 12)
                    .background(.blue)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.bottom, 20)
                }
            }
        }
    }
}


#Preview {
    LaunchView()
}
