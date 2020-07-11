//
//  ContentView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//
//  Working Comment Test

import SwiftUI

enum overlayViews {
    case addGoal, editGoal, reflect, addRoutine, editRoutine, addProject, none
}

struct ContentView: View {
    
    @EnvironmentObject var userData: UserData
    @State var currentOverlay : overlayViews = .none
    @State var addingItem = false
    @State var selection = 1
    
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
            
            TabView(selection: $selection) {
                
                ReflectView().tabItem({
//                    Image(systemName: "add")
                    Text("Reflect")
                }).tag(0)
                
                TodayView(userData: _userData).tabItem({
                    Image(systemName: "add")
                    Text("Today")
                }).tag(1)
                
                RoutineView(userData: _userData).tabItem({
                    Image(systemName: "add")
                    Text("Plan")
                }).tag(2)
                
//                ProjectView(userData: _userData, addingProject: false).tabItem({
//
//                    Text("Projects")
//
//                })
                
                
                
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

