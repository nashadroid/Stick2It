//
//  TodayView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/8/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct TodayView: View {
    @EnvironmentObject var userData: UserData
    @State var goalBeingEditedID: Int = 0
    @State var currentOverlay = overlayViews.none
    let dayIndex = Calendar.current.component(.weekday, from: Date()) - 1
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 0){
                Text("Today's Goals")
                    .foregroundColor(Color.black)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.top, 10)
                    .padding(.leading, 20)
                    .multilineTextAlignment(.leading)
                Text(userData.getNote(day: (getStringFromDate(date: getYesterday()) + "Tomorrow") ))
                    .italic()
                    .foregroundColor(.gray)
                    .padding(.leading, 20)
                    .padding(.bottom, 10)
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 10){
                        
                        ForEach(userData.userGoals) {goal in
                            if  Calendar.current.isDateInToday(goal.startTime){
                                GoalBox(goal: goal)
                                .onLongPressGesture {
                                    self.goalBeingEditedID = goal.id
                                    self.currentOverlay = .editGoal
                                }
                            }
                        }
                        Button(action: {
                            softGenerator.impactOccurred()
                            self.currentOverlay = .reflect
                        }){
                            
                            ReflectButton()
                            
                        }
                        .padding(.top, 10)
                    }
                    .padding()
                }
            }
            // ADD BUTTON
            GeometryReader { geo in
                Button(action: {self.currentOverlay = .addGoal}) {
                    AddButton()
                }
                .scaleEffect(0.2)
                .offset(x: geo.size.width * 0.35, y: geo.size.height * 0.42)
            }
            
            overlayView()
            
        }
    }
    func overlayView() -> AnyView {
        
        switch self.currentOverlay {
        case .addGoal:
            return AnyView(GeometryReader{_ in
                BlurView(style: .light)
                    .onTapGesture {
                        self.currentOverlay = .none
                }
                AddGoalNoBack(userData: self._userData, currentOverlay: self.$currentOverlay)
                    .padding(.top, 40)
            }.background(
                Color.black.opacity(0.65)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.currentOverlay = .none
                }
            )
                .edgesIgnoringSafeArea(.all)
            )
            
        case .editGoal:
            return AnyView(GeometryReader{_ in
                BlurView(style: .light)
                    .onTapGesture {
                        self.currentOverlay = .none
                }
                EditGoal(userData: self._userData, goalID: self.goalBeingEditedID, currentOverlay: self.$currentOverlay)
                    .padding(.top, 40)
            }.background(
                Color.black.opacity(0.65)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.currentOverlay = .none
                }
            )
                .edgesIgnoringSafeArea(.all)
            )
            
        case .reflect:
            return AnyView(GeometryReader{_ in
                BlurView(style: .light)
                    .onTapGesture {
                        self.currentOverlay = .none
                }
                VStack{
                    Spacer()
                    ReflectionPage(
                        currentOverlay: self.$currentOverlay,
                        todayReflect: self.userData.getNote(day: getStringFromDate(date: Date())+"Today"),
                        tomorrowMessage: self.userData.getNote(day: getStringFromDate(date: Date())+"Tomorrow")
                    )
                        .padding(20)
                    Spacer()
                }
            }.background(
                Color.black.opacity(0.65)
                    .edgesIgnoringSafeArea(.all)
                    .onTapGesture {
                        self.currentOverlay = .none
                }
            )
                .edgesIgnoringSafeArea(.all)
            )
            
        default:
            return AnyView(Text(""))
            
        }
        
    }
}

struct TodayView_Previews: PreviewProvider {
    static var previews: some View {
        TodayView()
    }
}
