//
//  AddButton.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/7/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct AddButton: View {
    
    var body: some View {
        let size = min(UIScreen.main.bounds.size.width, UIScreen.main.bounds.size.height)
        
        return ZStack {
            Circle()
                .fill(Color.white)
                .frame(width: size, height: size)
                .shadow(radius: size/10)
            
            RoundedRectangle(cornerRadius: size/20, style: .continuous)
            .fill(Color.blue)
            .frame(width: size/10, height: size*7/10)
            
            RoundedRectangle(cornerRadius: size/20, style: .continuous)
            .fill(Color.blue)
            .frame(width: size*7/10, height: size/10)
        }
        
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton()
    }
}
