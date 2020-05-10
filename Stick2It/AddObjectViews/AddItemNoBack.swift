//
//  AddItemNoBack.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/7/20.
//  Copyright © 2020 NashApps. All rights reserved.
//
//  This view helps create a new goal

import SwiftUI

struct AddItemNoBack: View {
    @EnvironmentObject var userData: UserData
    @State var addingItem = true
    @State private var name: String = ""
    @State private var startTime: String = ""
    @State private var endTime: String = ""
    @State private var date: String = "none"
    @State private var project: String = "none"
    
    
    var body: some View {
        VStack{
            Text("New Goal")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
                
            
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
            
            Button(action:{
                let today = Date()
                let formatter1 = DateFormatter()
                formatter1.dateFormat = "YD"
                print(formatter1.string(from: today))
                
                self.userData.addData(self.name, self.startTime, self.endTime, formatter1.string(from: today), "none")
                self.userData.saveData()
                self.addingItem.toggle()
                
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
        .padding()
        .background(Color(red: 0.0, green: 0.0, blue: 0.0, opacity: 0.00001)) //This is annoying, but it needs to exist to prevent accidental closure of view
        .padding(30)
    }
}

struct AddItemNoBack_Previews: PreviewProvider {
    static var previews: some View {
        AddItemNoBack()
    }
}
