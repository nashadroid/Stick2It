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
    @State private var name: String = ""
    @State private var startTime: String = ""
    @State private var endTime: String = ""
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text("New Goal")
                .font(.largeTitle)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.black)
            
            VStack(alignment: .leading){
                Text("Goal Name:")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .padding(.leading, 5)
                    .foregroundColor(Color.black)
                TextField("Enter goal name", text: $name)
                    .multilineTextAlignment(.center)
            }
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1))
            .padding(.top, 20)
            
            VStack(alignment: .leading){
                Text("Start Time:")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .padding(.leading, 5)
                    .foregroundColor(Color.black)
                TextField("Enter Start Time", text: $startTime)
                    .multilineTextAlignment(.center)
            }
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1))
            .padding(.top, 20)
            
            VStack(alignment: .leading){
                Text("End Time:")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .padding(.leading, 5)
                    .foregroundColor(Color.black)
                    //.multilineTextAlignment(.leading)
                
                TextField("Enter End Time", text: $endTime)
                    .multilineTextAlignment(.center)
            }
            .padding(5)
            .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1))
            .padding(.top, 20)
            
            
                //.padding(.bottom, 20)
            
            
            
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
