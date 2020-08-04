//
//  MenuBurger.swift
//  Stick2It
//
//  Created by Nashad Rahman on 7/29/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct MenuBurger: View {
    var body: some View {
        let size: CGFloat = 40.0
        let fillColor = Color(red: 0.3, green: 0.5, blue: 1)
        
        return ZStack {
            
            RoundedRectangle(cornerRadius: size/20, style: .continuous)
                .fill(fillColor)
                .frame(width: size*7/10, height: size/10)
                .offset(y: size/5)
            
            RoundedRectangle(cornerRadius: size/20, style: .continuous)
                .fill(fillColor)
                .frame(width: size*7/10, height: size/10)
            
            RoundedRectangle(cornerRadius: size/20, style: .continuous)
                .fill(fillColor)
                .frame(width: size*7/10, height: size/10)
                .offset(y: -size/5)
        }
        .frame(width: size, height: size)
        
    }
}

struct MenuBurger_Previews: PreviewProvider {
    static var previews: some View {
        MenuBurger()
    }
}
