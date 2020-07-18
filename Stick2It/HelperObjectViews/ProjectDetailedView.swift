//
//  ProjectDetailedView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/13/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct ProjectDetailedView: View {
    @EnvironmentObject var userData: UserData
    @State var project: Project 
    
    var projIndex: Int {
        userData.userProjects.firstIndex(where: { $0.id == project.id }) ?? 0
    }
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 0){
                Text(self.userData.userProjects[self.projIndex].projectName)
                    .foregroundColor(Color.black)
                    .font(.largeTitle)
                    .fontWeight(.heavy)
                    .padding()
                    .padding(.leading, 10)
                    .multilineTextAlignment(.leading)
                ScrollView(.vertical, showsIndicators: false){
                    VStack(spacing: 10){
                        
                        ForEach(userData.userGoals) {goal in
                            if  (goal.project == self.userData.userProjects[self.projIndex].projectName){
                                GoalBox(goal: goal)
                            }
                        }
                    }
                    .padding()
                    .frame(minWidth: UIScreen.main.bounds.size.width)
                    
                }
                
            }
            
        }
    }
}

//struct ProjectDetailedView_Previews: PreviewProvider {
//    static var previews: some View {
//        ProjectDetailedView()
//    }
//}
