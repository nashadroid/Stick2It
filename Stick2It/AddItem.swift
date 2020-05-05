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
                
            
            Text("Goal Name:")
                .font(.headline)
                .fontWeight(.heavy)
                .padding(.top, 40)
            TextField("Enter goal name", text: $name)
                .multilineTextAlignment(.center)
            
            Text("Start Time:")
                .font(.headline)
                .fontWeight(.heavy)
                .padding(.top, 20)
            TextField("Enter Start Time", text: $startTime)
                .multilineTextAlignment(.center)
            
            Text("End Time:")
                .font(.headline)
                .fontWeight(.heavy)
                .padding(.top, 20)
            TextField("Enter End Time", text: $endTime)
                .multilineTextAlignment(.center)
                .padding(.bottom, 20)
            
            
            
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
