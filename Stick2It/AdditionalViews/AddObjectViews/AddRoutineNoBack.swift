//
//  AddRoutineNoBack.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/5/20.
//  Copyright © 2020 NashApps. All rights reserved.
//
//  This view helps create a new Routine

import SwiftUI

struct AddRoutineNoBack: View {
    @EnvironmentObject var userData: UserData
    @Binding var currentOverlay: overlayViews
    @State private var name: String = ""
    @State private var startTime: Date = getLastHour()
    @State private var endTime: Date = getNextHour()
    @State private var scheduled: Bool = true
    //@State private var date: String = "none" 
    @State private var project: String = "none"
    @State private var repeatDays = [1,2]
    @State var daysOfWeek = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    @State var daysSelected = [false,false,false,false,false,false,false]
    
    
    var body: some View {
        
        VStack(alignment: .center){
            
            HStack{
                Button(action: {self.currentOverlay = .none})
                {
                    Text("Cancel")
                        .foregroundColor(Color.white)
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                }
                Spacer()
                
                Button(action:{
                    self.userData.addRoutine(
                        routineName: self.name,
                        startTime: self.startTime,
                        endTime: self.endTime,
                        scheduled: self.scheduled,
                        repeatOn: self.daysSelected,
                        project: self.project)
                    self.userData.saveRoutine()
                    self.currentOverlay = .none
                }){
                    Text("Done")
                        .foregroundColor(Color.white)
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                }
            }
            
            Text("New Routine")
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
                        TextField("Enter Routine name", text: $name)
                            .multilineTextAlignment(.center)
                    }
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                    
                    HStack(alignment: .center){
                        Text("Scheduled")
                            .font(.footnote)
                            .fontWeight(.heavy)
                            .padding(.leading, 5)
                            .foregroundColor(Color.white)
                        Toggle(isOn: $scheduled){
                            Text("")
                        }
                        .padding(5)
                    }
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                    .padding(.top, 20)
                    
                    if self.scheduled{
                        
                    VStack(alignment: .leading){
                        Text("Start Time:")
                            .font(.footnote)
                            .fontWeight(.heavy)
                            .padding(.leading, 5)
                            .foregroundColor(Color.white)
                        
                        
                            DatePicker("Please enter a date", selection: $startTime, displayedComponents: .hourAndMinute)
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
                        
                        DatePicker("Please enter a date", selection: $endTime, displayedComponents: .hourAndMinute)
                            .labelsHidden()
                            .multilineTextAlignment(.center)
                        
                    }
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                    .padding(.top, 20)
                    
                    HStack{
                        
                        ForEach(self.daysOfWeek.indices){index in
                            
                            Button(action: {
                                self.daysSelected[index].toggle()
                            }){
                                Text(self.daysOfWeek[index])
                            }
                            .padding(5)
                            .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1))
                            .background(self.daysSelected[index] ? Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.3) : Color.clear)
                            .foregroundColor(Color.white)
                        }
                        
                        
                    }
                    .padding(.top, 10)
                    
                    }
//                    VStack(alignment: .leading){
//                        Text("Project:")
//                            .font(.footnote)
//                            .fontWeight(.heavy)
//                            .padding(.leading, 5)
//                            .foregroundColor(Color.white)
//                        
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
//                    
                    
                    Button(action:{
                        self.userData.addRoutine(
                            routineName: self.name,
                            startTime: self.startTime,
                            endTime: self.endTime,
                            scheduled: self.scheduled,
                            repeatOn: self.daysSelected,
                            project: self.project)
                        
                        self.userData.saveRoutine()
                        self.currentOverlay = .none
                        
                    }){
                        Text("Add Routine")
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

//struct AddRoutineNoBack_Previews: PreviewProvider {
//    @State var addingItem: Bool = false
//    
//    static var previews: some View {
//        AddRoutineNoBack(currentOverlay: self.$currentOverlay)
//    }
//}
