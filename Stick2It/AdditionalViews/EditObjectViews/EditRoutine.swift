//
//  EditRoutine.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/21/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct EditRoutine: View {
    @EnvironmentObject var userData: UserData
    @Binding var currentOverlay: overlayViews
    let routineID: Int
    @State var daysOfWeek = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    
    var routineIndex: Int {
        userData.userRoutines.firstIndex(where: { $0.id == routineID }) ?? 0
    }
    
    var body: some View {
        VStack{
            
            HStack{
                Button(action: {
                    self.currentOverlay = .none
                    self.userData.refresh()
                })
                {
                    Text("Cancel")
                        .foregroundColor(Color.white)
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                }
                Spacer()
                Button(action: {
                    self.userData.saveRoutine()
                    self.currentOverlay = .none
                }) {
                    Text("Done")
                        .foregroundColor(Color.white)
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                }
            }
            
            Text("Edit Routine")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    VStack(alignment: .leading){
                        Text("Routine Name:")
                            .font(.footnote)
                            .fontWeight(.heavy)
                            .padding(.leading, 5)
                            .foregroundColor(Color.white)
                        TextField("Enter Routine name", text: $userData.userRoutines[self.routineIndex].routineName)
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
                        
                        
                        DatePicker("Please enter a date", selection: $userData.userRoutines[self.routineIndex].startTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .multilineTextAlignment(.center)
                        
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
                        
                        DatePicker("Please enter a date", selection: $userData.userRoutines[self.routineIndex].endTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .multilineTextAlignment(.center)
                        
                    }
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                    .padding(.top, 20)
                    
                    HStack{
                        
                        ForEach(self.daysOfWeek.indices){index in
                            
                            Button(action: {
                                self.userData.userRoutines[self.routineIndex].repeatOn[index].toggle()
                            }){
                                Text(self.daysOfWeek[index])
                            }
                            .padding(5)
                            .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1))
                            .background(self.userData.userRoutines[self.routineIndex].repeatOn[index] ? Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.3) : Color.clear)
                            .foregroundColor(Color.white)
                        }
                        
                        
                    }
                    .padding(.top, 10)
                    
                    VStack(alignment: .leading){
                        Text("Project:")
                            .font(.footnote)
                            .fontWeight(.heavy)
                            .padding(.leading, 5)
                            .foregroundColor(Color.white)
                        
                        Picker("Select Project", selection: $userData.userRoutines[self.routineIndex].project) {
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
                        self.userData.saveRoutine()
                        self.currentOverlay = .none
                    }){
                        Text("Save Routine")
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.1))
                            .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                            .padding(.top, 20)
                        
                    }
                    
                    Button(action: {
                        self.currentOverlay = .none
                        self.userData.removeRoutine(routine: self.userData.userRoutines[self.routineIndex])
                        
                    }) {
                        Text("Delete")
                            .foregroundColor(Color.red)
                        
                    }
                    .padding(.top, 30)
                    .padding(.bottom, 15)
                }
                .padding(5)
                .padding(.bottom,500)
                
            }
        }
        .padding(.leading, 30)
        .padding(.trailing, 30)
    }
}

//struct EditRoutine_Previews: PreviewProvider {
//    static var previews: some View {
//        EditRoutine()
//    }
//}
