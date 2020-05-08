//
//  RoutineView.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/8/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct RoutineView: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        VStack(alignment: .leading, spacing: 0){
            Text("Routines")
                .foregroundColor(Color.black)
                .font(.largeTitle)
                .fontWeight(.heavy)
                .padding()
                .padding(.leading, 10)
                .multilineTextAlignment(.leading)
            ScrollView(.vertical, showsIndicators: false){
                VStack(spacing: 10){
                    
                    ForEach(userData.userRoutines) {routine in
                        RoutineBox(routine: routine)
                    }
                }
                .padding()
                .frame(minWidth: UIScreen.main.bounds.size.width)
            }
            
        }
        
    }
}

struct RoutineView_Previews: PreviewProvider {
    static var previews: some View {
        RoutineView()
    }
}
