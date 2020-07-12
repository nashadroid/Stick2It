//
//  ReflectButton.swift
//  Stick2It
//
//  Created by Nashad Rahman on 7/10/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct ReflectButton: View {
    
    var body: some View {
        HStack{
            
            VStack(alignment: .center){
                Text("How is Today?")
                    .font(.headline)
                    .padding(15)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .foregroundColor(Color.blue)
                    .lineLimit(1)
                    .cornerRadius(10)
                
            }
        }
//        .border(Color.white, width: 3)
            
            .background(
                RoundedRectangle(cornerRadius: 5)
                    .fill(Color(red: 246/255, green: 247/255, blue: 248/255))
                    .shadow(radius: 7)
            )
//        .onTapGesture {
//            self.generator.impactOccurred()
//        }
    }
}

struct ReflectButton_Previews: PreviewProvider {
    static var previews: some View {
        ReflectButton()
    }
}
