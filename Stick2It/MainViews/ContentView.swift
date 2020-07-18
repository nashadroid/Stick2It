//
//  ContentView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//
//  First View, calls on all others

import SwiftUI

enum overlayViews {
    case addGoal, editGoal, reflect, addRoutine, editRoutine, addProject, none
}

let generator = UIImpactFeedbackGenerator(style: .heavy)
let softGenerator = UIImpactFeedbackGenerator(style: .soft)

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State var currentOverlay : overlayViews = .none
    @State var addingItem = false
    @State var selection = 1
    
    var body: some View {
        
        TabView(selection: $selection) {
            
            ReflectView().tabItem({
                Image(systemName: "memories")
                    .font(.system(size: 20))
                Text("Past")
            }).tag(0)
            
            TodayView().tabItem({
                Image(systemName: "circle.bottomthird.split")
                    .font(.system(size: 20))
                Text("Today")
            }).tag(1)
            
            RoutineView().tabItem({
                Image(systemName: "calendar.circle")
                    .font(.system(size: 20))
                Text("Future")
            }).tag(2)
            
        }
        
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(UserData())
    }
}

