//
//  ContentView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

enum CurrentView {
    case TodayView
    case RoutineView
}

struct ContentView: View {
    
    @EnvironmentObject var userData: UserData
    @State var addingItem = false
    @State var date: String = "none"
    @State var currentView = CurrentView.TodayView
    
    var body: some View {
        
        ZStack{
            
            //This is the background to prevent dark mode from affecting visuals.
            GeometryReader{_ in
                BlurView(style: .light)
                    .onTapGesture {
                        self.addingItem.toggle()
                }
            }.background(
                Color.white.opacity(1.0)
                    .edgesIgnoringSafeArea(.all)
            )
                .edgesIgnoringSafeArea(.all)
            
            TabView {
                
                TodayView(userData: _userData, date: date).tabItem({
                    
                    Image(systemName: "add")
                    Text("Today")
                    
                }).tag(0)
                
                RoutineView(userData: _userData, addingRoutine: false).tabItem({
                    
                    Image(systemName: "add")
                    Text("Routines")
                    
                }).tag(0)
                
                ProjectView(userData: _userData, addingProject: false).tabItem({
                    
                    Text("Projects")
                    
                })
                
                
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
    }
}

