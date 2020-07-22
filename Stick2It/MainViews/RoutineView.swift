//
//  RoutineView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/8/20.
//  Copyright © 2020 NashApps. All rights reserved.
//
//  Shows routines

import SwiftUI

struct RoutineView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var orientationInfo : OrientationInfo
    @State var currentOverlay = overlayViews.none
    @State var routineBeingEditedID: Int = 0
    let generator = UIImpactFeedbackGenerator(style: .soft)
    
    var body: some View {
        ZStack{
            if(orientationInfo.orientation == .portrait){
                VStack(alignment: .leading, spacing: 0){
                    
                    // Title
                    Text("Routines")
                        .foregroundColor(Color.black)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(.top, 10)
                        .padding(.leading, 20)
                        .padding(.bottom, 10)
                        .multilineTextAlignment(.leading)
                    
                    // Show Routines
                    ScrollView(.vertical, showsIndicators: false){
                        VStack(spacing: 10){
                            
                            ForEach(userData.userRoutines) {routine in
                                RoutineBox(routine: routine)
                                    .onLongPressGesture {
                                        softGenerator.impactOccurred()
                                        self.routineBeingEditedID = routine.id
                                        self.currentOverlay = .editRoutine
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                }
                
                // Add Buttone
                GeometryReader { geo in
                    Button(action: {
                        softGenerator.impactOccurred()
                        self.currentOverlay = .futureDecide
                    }) {
                        AddButton()
                        
                    }
                    .scaleEffect(0.2)
                    .offset(x: geo.size.width * 0.35, y: geo.size.height * 0.42)
                }
            } else {
                ScrollView(.horizontal, showsIndicators: false){
                    HStack{
                        ForEach(getNextWeek(), id: \.self){ day in
                            ScrollView(.vertical, showsIndicators: false){
                            VStack(alignment: .center, spacing: 10){
                                if Calendar.current.isDateInToday(day){
                                    Text("Today")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                } else if (Calendar.current.isDate(day, inSameDayAs: getTomorrow())) {
                                    Text("Tomorrow")
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                } else {
                                Text(getDayOfWeek(day: day))
                                    .font(.largeTitle)
                                    .fontWeight(.heavy)
                                }
                                ForEach(self.userData.userGoals.filter({Calendar.current.isDate(day, inSameDayAs: $0.startTime)})) {goal in
                                    FutureGoalBox(goal: goal)
                                    // This is to allow it to still scroll
                                    //                                    .onLongPressGesture {
                                    //                                        softGenerator.impactOccurred()
                                    //                                        self.goalBeingEditedID = goal.id
                                    //                                        self.currentOverlay = .editGoal
                                    //                                }
                                }
                                
                            }
                            .padding()
                            
                            }
                        }
                    }
                }
            }
            // Call on overlay
            overlayView()
        }
    }
    
    func overlayView() -> AnyView {
        
        switch self.currentOverlay {
            
        case .futureDecide:
            return AnyView(
                ZStack{
                    BlurView()
                        .edgesIgnoringSafeArea(.all)
                    
                    VStack{
                        Button(action: {self.currentOverlay = .addRoutine}){
                            Text("Routine")
                        }
                        .padding()
                        Button(action: {self.currentOverlay = .addFutureGoal}){
                            Text("Goal")
                        }
                        .padding()
                        
                    }
                }
            )
            
        // Add Routine overlay
        case .addRoutine:
            return AnyView(
                ZStack{
                    BlurView()
                        .edgesIgnoringSafeArea(.all)
                    
                    AddRoutineNoBack(userData: self._userData, currentOverlay: self.$currentOverlay)
                        .background(
                            Color.black.opacity(0.4)
                                .edgesIgnoringSafeArea(.all)
                                
                    )
                }
            )
        
            
        // Add Future Goal
        case .addFutureGoal:
            
            return AnyView(
                           ZStack{
                               BlurView()
                                   .edgesIgnoringSafeArea(.all)
                               
                               AddFutureGoalNoBack(userData: self._userData, currentOverlay: self.$currentOverlay)
                                   .background(
                                       Color.black.opacity(0.4)
                                           .edgesIgnoringSafeArea(.all)
                                           
                               )
                           }
                       )
            
        // Edit Routine Overlay
        case .editRoutine:
            return AnyView(
                ZStack{
                    BlurView()
                        .edgesIgnoringSafeArea(.all)
                    
                    EditRoutine(currentOverlay: self.$currentOverlay, routineID: self.routineBeingEditedID)
                        .background(
                            Color.black.opacity(0.4)
                                .edgesIgnoringSafeArea(.all)
                                
                    )
                }
            )
            
        default:
            return AnyView(Text(""))
            
        }
        
    }
    
}
