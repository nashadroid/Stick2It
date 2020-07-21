//
//  AddProjectNoBack.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/11/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct AddProjectNoBack: View {
    @EnvironmentObject var userData: UserData
    @Binding var currentOverlay: overlayViews
    @State private var projectName: String = ""
    
    var body: some View {
        
        VStack{
            
            HStack{
                Button(action: {self.currentOverlay = .none})
                {
                    Text("Cancel")
                        .foregroundColor(Color.white)
                        .padding(.top, 15)
                        .padding(.bottom, 15)
                }
                Spacer()
            }
            
            Text("New Project")
                .font(.largeTitle)
                .fontWeight(.heavy)
                .multilineTextAlignment(.center)
                .foregroundColor(Color.white)
            
            ScrollView(.vertical, showsIndicators: false){
                VStack{
                    VStack(alignment: .leading){
                        Text("Project Name:")
                            .font(.footnote)
                            .fontWeight(.heavy)
                            .padding(.leading, 5)
                            .foregroundColor(Color.white)
                        TextField("Enter Project name", text: $projectName)
                            .multilineTextAlignment(.center)
                    }
                    .padding(5)
                    .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                    
                    Button(action:{
                        self.userData.addProject(projectName: self.projectName)
                        self.userData.saveRoutine()
                        self.currentOverlay = .none
                        print(self.userData.userRoutines[0])
                        
                    }){
                        Text("Add Project")
                            .foregroundColor(Color.white)
                            .multilineTextAlignment(.center)
                            .padding()
                            .background(Color(red: 1.0, green: 1.0, blue: 1.0, opacity: 0.1))
                            .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color.white, lineWidth: 1))
                            .padding(.top, 20)
                        
                    }
                }
                .padding(5)
                .padding(.bottom,250)
                
            }
        }
        .padding(.leading, 20)
        .padding(.trailing, 30)
    }
}

//struct AddProjectNoBack_Previews: PreviewProvider {
//    static var previews: some View {
//        AddProjectNoBack(addingItem: .constant(false))
//    }
//}
