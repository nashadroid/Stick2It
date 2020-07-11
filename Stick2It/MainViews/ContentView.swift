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
            TabView(selection: $selection) {
                
                ReflectView().tabItem({
//                    Image(systemName: "add")
                    Text("Past")
                }).tag(0)
                
                TodayView().tabItem({
                    Text("Today")
                }).tag(1)
                
                RoutineView().tabItem({
                    Text("Future")
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

