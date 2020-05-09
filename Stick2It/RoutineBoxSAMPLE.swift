//
//  RoutineBox.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/8/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct RoutineBoxSAMPLE: View {
//    @EnvironmentObject var userData: UserData
//    @State var routine: Routine //TODO: Change this to be an index or ID only
//
//    var goalIndex: Int {
//        userData.userRoutines.firstIndex(where: { $0.id == routine.id })!
//    }
    var routineName = "Routine "
    var startTime = "9:35 am"
    var endTime = "10:05 pm"
    var repeatOn: [String] = ["Monday", "Wednesday", "Friday", "Saturday"]
    var project: String = "none"
    
    var body: some View{
        VStack() {
            
            Text(routineName)
            .font(.title)
            .fontWeight(.bold)
            .padding(4)
            .foregroundColor(Color.white)
            
            
            Text("\(startTime) - \(endTime)")
            .foregroundColor(Color.white)
            
            
            VStack(alignment: .leading, spacing: 0){
                HStack{
                        
                    Text("Project:")
                        .font(.body)
                        .fontWeight(.bold)
                        .padding(4)
                        .foregroundColor(Color.white)
                    
                    Text(project)
                        .font(.body)
                        .padding(4)
                        .foregroundColor(Color.white)
                    Spacer()
                }
                Text("Repeated On:")
                    .fontWeight(.bold)
                    .padding(4)
                    .foregroundColor(Color.white)
                Text(repeatOn.joined(separator: ", "))
                    .italic()
                    .padding(4)
                .foregroundColor(Color.white)
            }
            
            
        }
        .background(Color.green.shadow(radius: 7))
    }
    
    
}

struct RoutineBoxSAMPLE_Previews: PreviewProvider {
    static var previews: some View {
        RoutineBoxSAMPLE()
    }
}