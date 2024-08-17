//
//  User.swift
//  SwiftDataProject
//
//  Created by Mayur on 17/08/24.
//
import SwiftData
import Foundation

@Model
class User{
    var name: String
    var city: String
    var joiningDate: Date
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joiningDate = joinDate
    }
}

