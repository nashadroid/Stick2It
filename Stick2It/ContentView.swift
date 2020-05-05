//
//  ContentView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var userData: UserData
    @State var show = false
    
    var body: some View {
        Color.white
            .overlay(

                VStack{
                    ForEach(userData.userGoals) {goal in
                        GoalBox(goal: goal)
                        .padding(5)
                    }
                    
                    Button(action: {self.show = true}) {
                        Text("Add")
                    }
                    
                }
                .padding()
                .sheet(isPresented: $show, content: { AddItem() })
            
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
        .environmentObject(UserData())
    }
}

