//
//  AddItem.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/5/20.
//  Copyright © 2020 NashApps. All rights reserved.
//
//  This view helps create a new goal

import SwiftUI

struct AddRoutineNoBack: View {
    @EnvironmentObject var userData: UserData
    @Binding var addingItem: Bool
    @State private var name: String = ""
    @State private var startTime: Date = Date()
    @State private var endTime: Date = Date()
    @State private var date: String = "none"
    @State private var project: String = "none"
    @State private var repeatDays = [1,2]
    @State var daysOfWeek = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    @State var daysSelected = [false,false,false,false,false,false,false]
    
    
    var body: some View {
        
        VStack{
            
            HStack{
                Button(action: {self.addingItem.toggle()})
                {
                    Text("Cancel")
                        .foregroundColor(Color.white)
                        .padding()
                }
                Spacer()
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
                    
                    VStack(alignment: .leading){
                        Text("Project:")
                            .font(.footnote)
                            .fontWeight(.heavy)
                            .padding(.leading, 5)
                            .foregroundColor(Color.white)
                        
                        Picker("Select Project", selection: $project) {
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
                        self.userData.addRoutine(self.name, self.startTime, self.endTime, self.daysSelected, self.project)
                        self.userData.saveRoutine()
                        self.addingItem.toggle()
                        
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
                .padding(.bottom,500)
                
            }
                .padding(30)
        }
    }
}

struct AddRoutineNoBack_Previews: PreviewProvider {
    @State var addingItem: Bool = false
    
    static var previews: some View {
        AddRoutineNoBack(addingItem: .constant(false))
    }
}
