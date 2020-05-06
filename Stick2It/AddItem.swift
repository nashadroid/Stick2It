//
//  AddItem.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/5/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct AddItem: View {
    // @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var userData: UserData
    @State private var name: String = ""
    @State private var startTime: String = ""
    @State private var endTime: String = ""
    
    
    var body: some View {
        VStack{
            Text("New Goal")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.black)
                
            
            VStack(alignment: .leading){
                Text("Goal Name:")
                    .font(.footnote)
                    .fontWeight(.heavy)
                    .padding(.leading, 5)
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                TextField("Enter goal name", text: $name)
                    .multilineTextAlignment(.center)
            }
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1))
            .padding(.top, 20)
            
            VStack(alignment: .leading){
                Text("Start Time:")
                    .font(.footnote)
                    .fontWeight(.heavy)
                    .padding(.leading, 5)
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                TextField("Enter Start Time", text: $startTime)
                    .multilineTextAlignment(.center)
            }
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1))
            .padding(.top, 20)
            
            VStack(alignment: .leading){
                Text("End Time:")
                    .font(.footnote)
                    .fontWeight(.heavy)
                    .padding(.leading, 5)
                    .foregroundColor(Color(red: 0.2, green: 0.2, blue: 0.2))
                    //.multilineTextAlignment(.leading)
                
                TextField("Enter End Time", text: $endTime)
                    .multilineTextAlignment(.center)
            }
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1))
            .padding(.top, 20)
            
            Button(action:{
                
                self.userData.addData(self.name, self.startTime, self.endTime)
                
            }){
                Text("Add Goal")
                .multilineTextAlignment(.center)
                .padding()
            }
            
            
            
            
        }
        .padding()
        .background(Color.white.shadow(radius: 7))
        .padding(30)
    }
}

struct AddItem_Previews: PreviewProvider {
    static var previews: some View {
        AddItem()
    }
}
