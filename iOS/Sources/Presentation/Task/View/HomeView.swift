//
//  HomeView.swift
//  TM
//
//  Created by 최형우 on 2022/02/24.
//  Copyright © 2022 baegteun. All rights reserved.
//

import SwiftUI
import Service

struct HomeView: View {
    @StateObject var viewModel: TaskVM = AppDelegate.container.resolve(TaskVM.self)!
    @Namespace var animation
    
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
                                    
                                    Circle()
                                        .fill(.white)
                                        .frame(width: 8, height: 8)
                                        .opacity(viewModel.isCurrentDate(day) ? 1 : 0)
                                }
                                .foregroundColor(viewModel.isCurrentDate(day) ? .white : .black)
                                .frame(width: 45, height: 90)
                                .background(
                                    ZStack {
                                        if viewModel.isCurrentDate(day) {
                                            Capsule()
                                                .fill(.black)
                                                .matchedGeometryEffect(id: "CURRENTDATE", in: animation)
                                        }
                                    }
                                )
                                .contentShape(Capsule())
                                .onTapGesture {
                                    withAnimation {
                                        viewModel.currentDate = day
                                    }
                                }
                            }
                        }
                        .padding(.horizontal)
                    }
                    
                    TasksView()
                } header: {
                    HeaderView()
                }

            }
        }
        .ignoresSafeArea(.container, edges: .top)
    }
    
    // MARK: TasksView
    func TasksView() -> some View {
        LazyVStack(spacing: 20) {
            if let tasks = viewModel.filteredTasks {
                if tasks.isEmpty {
                    Text("No task found")
                        .font(.system(size: 16))
                        .fontWeight(.light)
                        .offset(y: 100)
                } else {
                    ForEach(tasks, id: \.id) { task in
                        TaskCardView(task: task)
                    }
                }
            } else {
                ProgressView()
                    .offset(y: 100)
            }
        }
        .padding()
        .padding(.top)
        .onChange(of: viewModel.currentDate) { newValue in
            viewModel.filterTodayTasks()
        }
    }
    
    // MARK: - TaskCardView
    func TaskCardView(task: BTask) -> some View {
        HStack(alignment: .top, spacing: 30) {
            VStack {
                Circle()
                    .fill(viewModel.isCurrentHour(task.taskDate) ? .black : .clear)
                    .frame(width: 15, height: 15)
                    .background(
                        Circle()
                            .stroke(.black, lineWidth: 1)
                            .padding(-3)
                    )
                    .scaleEffect(!viewModel.isCurrentHour(task.taskDate) ? 0.8 : 1)
                Rectangle()
                    .fill(.black)
                    .frame(width: 3)
            }
            VStack {
                HStack(alignment: .top, spacing: 10) {
                    VStack(alignment: .leading, spacing: 12) {
                        Text(task.taskTitle)
                            .font(.title2.bold())
                        Text(task.taskDescription)
                            .font(.callout)
                    }
                    .hLeading()
                    
                    Text(task.taskDate.extractDate(format: "hh:MM a"))
                }
                
                // MARK: Memeber
                if viewModel.isCurrentHour(task.taskDate) {
                    HStack(spacing: 0) {
                        HStack(spacing: -10) {
                            ForEach([
                                "https://avatars.githubusercontent.com/u/63863135?s=100&v=4",
                                "https://avatars.githubusercontent.com/u/28175067?s=100&v=4"],
                                    id: \.self) { user in
                                Image(uiImage: URL(string: user)?.toImage() ?? .init())
                                    .resizable()
                                    .aspectRatio(contentMode: .fill)
                                    .frame(width: 45, height: 45)
                                    .clipShape(Circle())
                                    .background(
                                        Circle()
                                            .stroke(.black, lineWidth: 5)
                                    )
                            }
                        }
                        .hLeading()
                        Button {
                            
                        } label: {
                            Image(systemName: "checkmark")
                                .foregroundColor(.black)
                                .padding(10)
                                .background(
                                    Rectangle()
                                        .background(Color.white)
                                        .cornerRadius(10)
                                        .clipped()
                                    
                                )
                        }
                    }
                    .padding(.top)
                }
            }
            .foregroundColor(viewModel.isCurrentHour(task.taskDate) ? .white : .black)
            .padding(viewModel.isCurrentHour(task.taskDate) ? 15 : 0)
            .padding(.bottom, viewModel.isCurrentHour(task.taskDate) ? 0 : 10)
            .hLeading()
            .background(
                Color.black
                    .cornerRadius(25)
                    .opacity(viewModel.isCurrentHour(task.taskDate) ? 1 : 0)
            )
        }
        .hLeading()
    }
    // MARK: HeaderView
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
        .padding(.top, getSafeArea().top)
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
