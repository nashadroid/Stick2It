//
//  EditGoal.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/18/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct EditGoal: View {
    @EnvironmentObject var userData: UserData
    var goalID: Int
    @Binding var currentOverlay: overlayViews
    
    var goalIndex: Int {
        userData.userGoals.firstIndex(where: { $0.id == goalID }) ?? 0
    }
    
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
                    self.userData.saveGoal()
                    self.currentOverlay = .none
                }) {
                    Text("Done")
                        .foregroundColor(Color.white)
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                }
            }
            
            Text("Edit Goal")
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
                        TextField("Enter goal name", text: $userData.userGoals[goalIndex].goalName)
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
                        DatePicker("Please enter a date", selection: $userData.userGoals[goalIndex].startTime, displayedComponents: .hourAndMinute)
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
                        
                        DatePicker("Please enter a date", selection: $userData.userGoals[goalIndex].endTime, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                    }
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                    .padding(.top, 20)
                    
                    VStack(alignment: .leading){
                        Text("Project:")
                            .font(.footnote)
                            .fontWeight(.heavy)
                            .padding(.leading, 5)
                            .foregroundColor(Color.white)
                        Picker("Select Project", selection: $userData.userGoals[goalIndex].project) {
                            Text("none")
                            ForEach(userData.userProjects.map({ (project: Project) -> String in project.projectName}), id: \.self) {option in
                                Text(option)
                            }
                        }
                        .labelsHidden()
                        .pickerStyle(WheelPickerStyle())
                    }
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                    .padding(.top, 20)
                    
                    Button(action:{
                        self.userData.saveGoal()
                        self.currentOverlay = .none
                        
                    }){
                        Text("Update Goal")
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.1))
                            .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                            .padding(.top, 20)
                        
                    }
                    
                    Button(action: {
                        self.userData.removeGoal(goal: self.userData.userGoals[self.goalIndex])
                        self.currentOverlay = .none
                    }) {
                        Text("Delete")
                            .foregroundColor(Color.red)
                            
                    }
                    .padding(.top, 30)
                }
            .padding(5)
            .padding(.bottom,500)
                
            }
            
        }
        .padding(.leading, 30)
        .padding(.trailing, 30)
    }
}

//struct EditGoal_Previews: PreviewProvider {
//    static var previews: some View {
//        EditGoal()
//    }
//}
