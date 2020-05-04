//
//  ContentView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/4/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    
    
    var defaultGoalList = [Goal(goalName: "Goal 1", done: true), Goal(goalName: "Goal 2", done: false), Goal(goalName: "Goal 3", done: false), Goal(goalName: "Goal 4", done: true)]
    
    var body: some View {
        Color.white
            .overlay(
                VStack{
                    
                    ForEach(defaultGoalList, id: \.id) {
                        GoalBox(goal: $0)
                        
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

