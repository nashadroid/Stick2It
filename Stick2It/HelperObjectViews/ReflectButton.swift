//
//  ReflectButton.swift
//  Stick2It
//
//  Created by Nashad Rahman on 7/10/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct ReflectButton: View {
    let generator = UIImpactFeedbackGenerator(style: .heavy)
    
    var body: some View {
        HStack{
            
            VStack(alignment: .center){
                Text("Reflect")
                    .font(.headline)
                    .fontWeight(.heavy)
                    .padding(15)
                    .padding(.leading, 30)
                    .padding(.trailing, 30)
                    .foregroundColor(Color.white)
                    .lineLimit(1)
                
            }
        }
        .border(Color.white, width: 3)
        .background(Color(red: 0.3, green: 0.4, blue: 0.9).shadow(radius: 7))
        .onTapGesture {
            self.generator.impactOccurred()
        }
    }
}

struct ReflectButton_Previews: PreviewProvider {
    static var previews: some View {
        ReflectButton()
    }
}
