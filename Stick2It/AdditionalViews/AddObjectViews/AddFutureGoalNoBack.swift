//
//  AddFutureGoalNoBack.swift
//  Stick2It
//
//  Created by Nashad Rahman on 7/22/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct AddFutureGoalNoBack: View {
    @EnvironmentObject var userData: UserData
    @Binding var currentOverlay: overlayViews
    @State private var name: String = ""
    @State private var startTime: Date = getLastHour()
    @State private var endTime: Date = getNextHour()
    @State private var date: String = "none"
    @State private var project: String = "none"
    
    
    var body: some View {
        VStack{
            
            HStack{
                Button(action: {self.currentOverlay = .none})
                {
                    Text("Cancel")
                        .foregroundColor(Color.white)
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                }
                Spacer()
                Button(action: {
                    self.userData.addGoal(
                        goalName: self.name,
                        startTime: self.startTime,
                        endTime: self.endTime,
                        scheduled: true,
                        remain: false,
                        project: self.project)
                    self.userData.saveGoal()
                    self.currentOverlay = .none
                    self.userData.saveGoal()
                    self.currentOverlay = .none
                }) {
                    Text("Add")
                        .foregroundColor(Color.white)
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                }
            }
            
            
            Text("New Goal")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    VStack(alignment: .leading){
                        Text("Goal Name:")
                            .font(.footnote)
                            .fontWeight(.heavy)
                            .padding(.leading, 5)
                            .foregroundColor(Color.white)
                        TextField("Enter goal name", text: $name)
                            .multilineTextAlignment(.center)
                    }
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                    
                    VStack(alignment: .leading){
                        Text("Start Time:")
                            .font(.footnote)
                            .fontWeight(.heavy)
                            .padding(.leading, 5)
                            .foregroundColor(Color.white)
                        DatePicker("Please enter a date", selection: $startTime)
                        .labelsHidden()
                    }
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading){
                        Text("End Time:")
                            .font(.footnote)
                            .fontWeight(.heavy)
                            .padding(.leading, 5)
                            .foregroundColor(Color.white)
                        
                        DatePicker("Please enter a date", selection: $endTime)
                        .labelsHidden()
                    }
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                    .padding(.top, 20)
                    
//                    VStack(alignment: .leading){
//                        Text("Project:")
//                            .font(.footnote)
//                            .fontWeight(.heavy)
//                            .padding(.leading, 5)
//                            .foregroundColor(Color.white)
//                        Picker("Select Project", selection: $project) {
//                            Text("none")
//                            ForEach(userData.userProjects.map({ (project: Project) -> String in project.projectName}), id: \.self) {option in
//                                Text(option)
//                            }
//                        }
//                        .labelsHidden()
//                        .pickerStyle(WheelPickerStyle())
//                    }
//                    .padding(5)
//                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
//                    .padding(.top, 20)
//
                    Button(action:{
                        self.userData.addGoal(
                            goalName: self.name,
                            startTime: self.startTime,
                            endTime: self.endTime,
                            scheduled: true,
                            remain: false,
                            project: self.project)
                        self.userData.saveGoal()
                        self.currentOverlay = .none
                    }){
                        Text("Add Goal")
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.1))
                            .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                            .padding(.top, 20)
                        
                    }
                }
            .padding(5)
            .padding(.bottom,250)
            }
        }
        .padding(.leading, 30)
        .padding(.trailing, 30)
    }
}

