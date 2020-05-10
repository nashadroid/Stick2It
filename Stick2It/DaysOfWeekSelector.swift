//
//  DaysOfWeekSelector.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/9/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct DaysOfWeekSelector: View {
    @State var daysOfWeek = ["sun", "mon", "tue", "wed", "thu", "fri", "sat"]
    @State var daysSelected = [false,false,false,false,false,false,false]
    
    var body: some View {
        
        return HStack{
            
            ForEach(self.daysOfWeek.indices){index in
                
                Button(action: {
                    self.daysSelected[index].toggle()
                }){
                    Text(self.daysOfWeek[index])
                    }
                .padding(5)
                .overlay(RoundedRectangle(cornerRadius: 2).stroke(Color(red: 0.9, green: 0.9, blue: 0.9), lineWidth: 1))
                .background(self.daysSelected[index] ? Color.black : Color.white)
            }
            
            
        }
    }
}

struct DaysOfWeekSelector_Previews: PreviewProvider {
    static var previews: some View {
        DaysOfWeekSelector()
    }
}
