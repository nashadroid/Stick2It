//
//  ReflectionPage.swift
//  Stick2It
//
//  Created by Nashad Rahman on 7/10/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct ReflectionPage: View {
    @EnvironmentObject var userData: UserData
    @Binding var currentOverlay: overlayViews
    @State var todayReflect: String = ""
    @State var tomorrowMessage: String = ""
    
    
    var body: some View {
        VStack(alignment: .leading){
            Text("How is today going?")
                .font(.headline)
                .padding(15)
                .foregroundColor(Color.black)
                .lineLimit(2)
            TextField("Write something about today", text: self.$todayReflect)
            .padding(15)
            .lineLimit(2)
            
            Text("What would you like to tell yourself tomorrow?")
                .font(.headline)
                .padding(15)
                .foregroundColor(Color.black)
                .lineLimit(2)
            TextField("Write something for tomorrow", text: $tomorrowMessage)
                .lineLimit(2)
                .padding(15)
            HStack{
                Spacer()
                Button(action: {
                    self.currentOverlay = .none
                    self.userData.addNote(note: self.todayReflect, day: getStringFromDate(date: Date())+"Today")
                    self.userData.addNote(note: self.tomorrowMessage, day: getStringFromDate(date: Date())+"Tomorrow")
                    softGenerator.impactOccurred()
                }) {
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
