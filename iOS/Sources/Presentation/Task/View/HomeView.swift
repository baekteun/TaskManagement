//
//  HomeView.swift
//  TM
//
//  Created by 최형우 on 2022/02/24.
//  Copyright © 2022 baegteun. All rights reserved.
//

import SwiftUI

struct HomeView: View {
    @StateObject var viewModel: TaskVM = AppDelegate.container.resolve(TaskVM.self)!
    var body: some View {
        ScrollView(.vertical, showsIndicators: false) {
            LazyVStack(spacing: 15, pinnedViews: [.sectionHeaders]) {
                Section {
                    ScrollView(.horizontal, showsIndicators: false) {
                        HStack(spacing: 10) {
                            ForEach(viewModel.currentWeek, id: \.self) { day in
                                VStack(spacing: 10) {
                                    Text(day.extractDate(format: "dd"))
                                        .font(.system(size: 14))
                                        .fontWeight(.semibold)
                                    
                                    Text(day.extractDate(format: "EEE"))
                                        .font(.system(size: 14))
                                    
                                    if day.isToday() {
                                        Circle()
                                            .fill(.white)
                                            .frame(width: 8, height: 8)
                                    }
                                }
                                .foregroundColor(.white)
                                .frame(width: 45, height: 90)
                                .background(
                                    ZStack {
                                        Capsule()
                                            .fill(.black)
                                        
                                    }
                                )
                            }
                        }
                        .padding(.horizontal)
                    }
                } header: {
                    HeaderView()
                }

            }
        }
    }
    
    func HeaderView() -> some View {
        HStack(spacing: 10) {
            VStack(alignment: .leading, spacing: 10) {
                if #available(iOS 15.0, *) {
                    Text(Date().formatted(date: .abbreviated, time: .omitted))
                        .foregroundColor(.gray)
                } else {
                    Text(Date().extractDate(format: "EEE m, yyyy"))
                        .foregroundColor(.gray)
                }
                Text("Today")
                    .font(.largeTitle.bold())
            }
            .hLeading()
            
            Button {
                
            } label: {
                Image("Baekteun")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(width: 45, height: 45)
                    .clipShape(Circle())
            }
        }
        .padding()
        .background(Color.white)
    }
}

struct HomeView_Previews: PreviewProvider {
    static var previews: some View {
        Group{
            HomeView()
        }
    }
}
