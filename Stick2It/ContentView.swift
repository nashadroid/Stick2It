//
//  ContentView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    var body: some View {
        Color.white
            .overlay(
                VStack{
                    ForEach(GoalData) {goal in
                        GoalBox(goal: goal)
                        .padding(5)
                    }
                }
                .padding()
        )
        .edgesIgnoringSafeArea(.all)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

