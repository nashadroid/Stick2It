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
    @State var addingItem = true
    @State private var name: String = ""
    @State private var startTime: String = ""
    @State private var endTime: String = ""
    @State private var date: String = "none"
    @State private var project: String = "none"
    @State private var repeatDays = [1,2]
    
    
    var body: some View {
        VStack{
            Text("New Routine")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
                
            
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
            .padding(.top, 20)
            
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
            
            VStack(alignment: .leading){
                Text("Repeats On:")
                    .font(.footnote)
                    .fontWeight(.heavy)
                    .padding(.leading, 5)
                    .foregroundColor(Color.white)
                
                TextField("Enter Repeat Days", text: $endTime)
                    .multilineTextAlignment(.center)
            }
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
            .padding(.top, 20)
            
            Button(action:{
                self.userData.addRoutine(self.name, self.startTime, self.endTime, self.repeatDays, "none")
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
        .padding()
        .background(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.00001)) //This is annoying, but it needs to exist to prevent accidental closure of view
        .padding(30)
    }
}

struct AddRoutineNoBack_Previews: PreviewProvider {
    static var previews: some View {
        AddRoutineNoBack()
    }
}
