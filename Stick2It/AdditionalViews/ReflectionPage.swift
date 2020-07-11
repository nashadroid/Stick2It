//
//  ReflectionPage.swift
//  Stick2It
//
//  Created by Nashad Rahman on 7/10/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct ReflectionPage: View {
    @Binding var currentOverlay: overlayViews
    @State private var todayReflect: String = ""
    @State private var tomorrowMessage: String = ""
    
    var body: some View {
        VStack(alignment: .leading){
            Text("How is today going?")
                .font(.headline)
                .padding(15)
                .foregroundColor(Color.black)
            TextField("Write something about today", text: $todayReflect)
                .padding(15)
            Text("What would you like to tell yourself tomorrow?")
                .font(.headline)
                .padding(15)
                .foregroundColor(Color.black)
            TextField("Write something for tomorrow", text: $tomorrowMessage)
                .padding(15)
            HStack{
                Spacer()
                Button(action: {self.currentOverlay = .none}) {
                       Text("Done")
                }
                .padding(20)
                Spacer()
                
            }
            
        }
        .background(
            RoundedRectangle(cornerRadius: 5)
                .fill(Color(red: 246/255, green: 247/255, blue: 248/255))
                .shadow(radius: 7)
        )
    }
}
