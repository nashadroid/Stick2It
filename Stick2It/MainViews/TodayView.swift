//
//  TodayView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/8/20.
//  Copyright © 2020 NashApps. All rights reserved.
//
//  Shows todays goals, allows reflection

import SwiftUI

struct TodayView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var orientationInfo : OrientationInfo
    @State var goalBeingEditedID: Int = 0
    @State var currentOverlay = overlayViews.none
    let dayIndex = Calendar.current.component(.weekday, from: Date()) - 1
    
    var body: some View {
        ZStack{
            
            VStack(alignment: .leading, spacing: 0){
                
                HStack {
                // Title
                Text("Today's Goals")
                    .foregroundColor(Color.black)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding(.top, 10)
                    .padding(.leading, 20)
                    .multilineTextAlignment(.leading)
                Spacer()
                    Button(action: {self.currentOverlay = .settingsMenu}){
                        MenuBurger()
                            .padding(.trailing)
                            .padding(.leading)
                        }
                    }
                
                
                // Show message from yesterday (My favorite part)
                if userData.getNote(day: (getStringFromDate(date: getYesterday()) + "Tomorrow")) != "" {
                    Text(userData.getNote(day: (getStringFromDate(date: getYesterday()) + "Tomorrow")))
                        .italic()
                        .foregroundColor(.gray)
                        .padding(.bottom, 10)
                } else {
                    Spacer(minLength: 10)
                }
                
                // Show goals of today
                ScrollView(.vertical){
                    VStack(alignment: .center, spacing: 10){
                        
                        ForEach(userData.userGoals.filter({Calendar.current.isDateInToday($0.startTime)  && $0.scheduled && $0.enabled && !$0.deleted})) {goal in
                            GoalBox(goal: goal)
                                // This is to allow it to still scroll
                                .onLongPressGesture {
                                softGenerator.impactOccurred()
                                self.goalBeingEditedID = goal.id
                                self.currentOverlay = .editGoal
                                }
                        }
                        ForEach(userData.userGoals.filter({Calendar.current.isDateInToday($0.startTime)  && !$0.scheduled && $0.enabled && !$0.deleted})) {goal in
                            GoalBox(goal: goal)
                                // This is to allow it to still scroll
                                .onLongPressGesture {
                                softGenerator.impactOccurred()
                                self.goalBeingEditedID = goal.id
                                self.currentOverlay = .editGoal
                                }
                        }
                        
                        if !(userData.userGoals.filter({Calendar.current.isDateInToday($0.startTime) && $0.enabled && !$0.deleted}).count > 0) {
                            Text("Looks like you haven't added any goals yet, press the \"+\" button to get started!")
                                .italic()
                                .foregroundColor(.gray)
                                .padding(.bottom, 10)
                                .multilineTextAlignment(.center)
                        }
                        
                        
                        // Reflect button
                        Button(action: {
                            softGenerator.impactOccurred()
                            self.currentOverlay = .reflect
                        }){
                            
                            ReflectButton()
                            
                        }
                        .padding(.top, 10)
                        
                    }
                    .padding()
                    .frame(maxWidth: .infinity)
                }
                
                
            }
            
            if(orientationInfo.orientation == .portrait){
            // ADD BUTTON
            GeometryReader { geo in
                Button(action: {
                    softGenerator.impactOccurred()
                    self.currentOverlay = .addGoal
                }) {
                    AddButton()
                    
                }
                
                .offset(x: geo.size.width * 0.35, y: geo.size.height * 0.42)
            }
                
            // Call the overlay
            overlayView()
            }
            
        }
        .frame(maxWidth: .infinity)
//        .background(Color.black)
    }
    func overlayView() -> AnyView {
        
        switch self.currentOverlay {
        
        // add goal screen
        case .addGoal:
            return AnyView(
                ZStack{
                    BlurView()
                        .edgesIgnoringSafeArea(.all)
                        .background(
                            Color.black.opacity(0.4)
                                .edgesIgnoringSafeArea(.all)
                    )
                    AddGoalNoBack(userData: self._userData, currentOverlay: self.$currentOverlay)
                }
            )
            
            
        // edit a goal
        case .editGoal:
            return AnyView(
                ZStack{
                    BlurView()
                        .edgesIgnoringSafeArea(.all)
                        .background(
                                Color.black.opacity(0.4)
                                    .edgesIgnoringSafeArea(.all)
                        )
                    EditGoal(userData: self._userData, goalID: self.goalBeingEditedID, currentOverlay: self.$currentOverlay)
                }
            )
            
        // reflect page
        case .reflect:
            return AnyView(
                ZStack{
                    BlurView()
                        .edgesIgnoringSafeArea(.all)
                        .background(
                            Color.black.opacity(0.4)
                                .edgesIgnoringSafeArea(.all)
                    )
                    .onTapGesture {
                            self.currentOverlay = .none
                    }
                    
                    ScrollView(showsIndicators: false){
                        VStack{
                            ReflectionPage(
                                currentOverlay: self.$currentOverlay,
                                todayReflect: self.userData.getNote(day: getStringFromDate(date: Date())+"Today"),
                                tomorrowMessage: self.userData.getNote(day: getStringFromDate(date: Date())+"Tomorrow")
                            )
                                .padding(20)
                                .padding(.top, 100)
                                .padding(.bottom, 400)
                            
                        }
                    }
                }
            )
            
        // settings
        case .settingsMenu:
            return AnyView(
                ZStack{
                    BlurView()
                        .edgesIgnoringSafeArea(.all)
                        .background(
                                Color.black.opacity(0.4)
                                    .edgesIgnoringSafeArea(.all)
                        )
                    SettingsMenu(currentOverlay: self.$currentOverlay)
                }
            )
            
        // It needs to return something, I think this is the best way to go about returning nothing
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
