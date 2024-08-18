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
    var name: String = "Anonomous"
    var city: String = "N/A"
    var joiningDate: Date = Date.now
    @Relationship(deleteRule: .cascade) var job: [Job]? = [Job]()
    
    var unrappedJob: [Job]{
        job ?? []
    }
    
    init(name: String, city: String, joinDate: Date) {
        self.name = name
        self.city = city
        self.joiningDate = joinDate
    }
}

