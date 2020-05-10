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
    @State private var startTime: String = ""
    @State private var endTime: String = ""
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
                //.padding(1)
                
            
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
                    TextField("Enter Start Time", text: $startTime)
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
                    
                    TextField("Enter End Time", text: $endTime)
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
                
                Button(action:{
                    self.userData.addRoutine(self.name, self.startTime, self.endTime, self.daysSelected, "none")
                    self.userData.saveRoutine()
                    self.addingItem.toggle()
                    print(self.userData.userRoutines[0])
                    
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
                
            }
            //.padding()
            //.background(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.00001)) //This is annoying, but it needs to exist to prevent accidental closure of view
                .padding(.leading, 30)
                .padding(.trailing, 30)
        }
        //.padding(.leading,20)
    }
}

struct AddRoutineNoBack_Previews: PreviewProvider {
    @State var addingItem: Bool = false
    
    static var previews: some View {
        AddRoutineNoBack(addingItem: .constant(false))
    }
}
