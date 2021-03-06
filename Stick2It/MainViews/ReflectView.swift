//
//  Reflect.swift
//  Stick2It
//
//  Created by Nashad Rahman on 7/10/20.
//  Copyright © 2020 NashApps. All rights reserved.
//
//  Shows past goals

import SwiftUI

struct ReflectView: View {
    @EnvironmentObject var userData: UserData
    @EnvironmentObject var orientationInfo : OrientationInfo
    @State var routineBeingEditedID: Int = 0
    @State var editingRoutine: Bool = false
    
    var body: some View {
        ZStack{
            if(orientationInfo.orientation == .portrait){
                
                VStack(alignment: .leading, spacing: 0){
                    // Title
                    Text("Yesterday's Goals")
                        .foregroundColor(Color.black)
                        .font(.largeTitle)
                        .fontWeight(.heavy)
                        .padding(.top, 10)
                        .padding(.leading, 20)
                        .padding(.bottom, 10)
                        .multilineTextAlignment(.leading)
                    
                    // Show Yesterday's goals
                    ScrollView(.vertical, showsIndicators: true){
                        VStack(spacing: 10){
                            
                            ForEach(self.userData.userGoals.filter({Calendar.current.isDate($0.startTime, inSameDayAs: getYesterday()) && $0.enabled && !$0.deleted})) {goal in
                                
                                ReflectionGoalBox(goal: goal)
                                    .onLongPressGesture {
                                        withAnimation(.easeInOut(duration: 0.15),{
                                            self.userData.userGoals[self.userData.getIndex(goal: goal)].done.toggle()
                                        })
                                        self.userData.saveGoal()
                                        softGenerator.impactOccurred()
                                }
                                
                            }
                            if !(self.userData.userGoals.filter({Calendar.current.isDate($0.startTime, inSameDayAs: getYesterday()) && $0.enabled && !$0.deleted}).count > 0) {
                                Text("Looks like you didn't have any goals yesterday, check back again tomorrow!")
                                    .italic()
                                    .foregroundColor(.gray)
                                    .padding(.bottom, 10)
                                    .multilineTextAlignment(.center)
                            }
                            
                            Text(userData.getNote(day: (getStringFromDate(date: getYesterday()) + "Today")) != "" ?
                                "\"" + userData.getNote(day: (getStringFromDate(date: getYesterday()) + "Today")) + "\"" : "")
                                .italic()
                                .foregroundColor(.gray)
                                .padding(.leading, 20)
                                .padding(.trailing, 20)
                                .padding(.top, 10)
                                .lineLimit(50)
                                .multilineTextAlignment(.leading)
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                    }
                }
            }
                
                // Show the past week if in landscape mode
            else{
                ScrollView(showsIndicators: false){
                    VStack(){
                        // Title
                        Text("Past Week")
                            .foregroundColor(Color.black)
                            .font(.largeTitle)
                            .fontWeight(.heavy)
                            .multilineTextAlignment(.leading)
                            .padding(.top, 20)
                        
                        // Make a stack of all routines
                        VStack(alignment: .trailing){
                            
                            
                            ForEach(userData.userRoutines, id: \.self){ routine in
                                // Make a stack of past day completions from routines
                                HStack{
                                    Text(routine.routineName)
                                        .fontWeight(.bold)
                                    ForEach(getPastWeek(), id: \.self){ day in
                                        RoundedRectangle(cornerRadius: 3)
                                            .fill(self.userData.goalDoneOnDay(goalName: routine.routineName, Date: day) == 0 ? Color.red : Color.green)
                                            .opacity(self.userData.goalDoneOnDay(goalName: routine.routineName, Date: day) == -1 ? 0.1 : 1)
                                            .frame(width: 30, height: 30)
                                    }
                                }
                            }
                            
                        }
                        .padding(.leading)
                        .padding(.bottom, 40)
                    }
                    .frame(maxWidth: .infinity)
                }
            }
        }
    }
}
