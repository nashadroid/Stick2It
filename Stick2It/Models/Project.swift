//
//  Project.swift
//  Stick2It
//
//  Created by Nashad Rahman on 5/11/20.
//  Copyright © 2020 NashApps. All rights reserved.
//

import SwiftUI

struct Project: Hashable, Codable, Identifiable {
    
    var id: Int
    var projectName: String
    var goalsWithin: [Int] = []
    var done: Bool = true
    
}
